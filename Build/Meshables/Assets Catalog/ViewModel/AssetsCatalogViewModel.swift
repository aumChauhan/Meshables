//
//  AssetsCatalogViewModel.swift
//  Meshables
//
//  Created by Aum Chauhan on 07/09/24.
//

import Combine
import SwiftUI
import SwiftData

/// Manages asset catalog data, including fetching and processing assets for display within the application.
@MainActor
class AssetsCatalogViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    private var subscriptions = Set<AnyCancellable>()
    internal var filterStates: String {
        "\(assetType.rawValue)-\(assetsCategories.description)-\(priceFilter)-\(discountOptions.description)"
    }
    
    @Published var assets: [Asset] = []
    @Published var filteredAssets: [Asset] = []
    
    @Published var searchText: String = ""
    @Published var assetType: AssetType = .models
    @Published var priceFilter: Double = 100.0
    @Published var assetsCategories: [AssetCategory: Bool] = [
        .livingRoom: false,
        .kitchen: false,
        .outdoor: false,
        .office: false,
        .sports: false,
        .electronics: false
    ]
    @Published var discountOptions: [DiscountOption] = [
        DiscountOption(title: "> 0%", discount: 0, isOn: false),
        DiscountOption(title: "> 30%", discount: 30, isOn: false),
        DiscountOption(title: "> 50%", discount: 50, isOn: false),
        DiscountOption(title: "> 70%", discount: 70, isOn: false),
        DiscountOption(title: "> 90%", discount: 90, isOn: false)
    ]
    
    @Published var assetOwnerDetails: UserProfile? = nil
    
    @Published var alertPresenter: Bool = false
    @Published var alertDescription: String = ""
    
    // MARK: - INITIALIZER
    
    init() {
        getAssets()
        filterAssetsBySearch()
    }
    
    // MARK: - SERVICES
    
    /// Fetches assets from the database and filters them by type and updates the `assets` property with the fetched data.
    func getAssets() {
        Task {
            do {
                assets = try await AssetManagement.shared.getAssets()
                filterAssets()
            } catch {
                exceptionHandler(error)
            }
        }
    }
    
    /// Retrieves the details of the asset owner from the database based on the user ID.
    func getAssetOwnerDetails(asset: Asset) {
        Task {
            do {
                guard let userId = asset.userId else {
                    throw URLError(.userAuthenticationRequired)
                }
                 assetOwnerDetails = try await UserCredentials.shared.getUserCredentials(from: userId)
            } catch {
                exceptionHandler(error)
            }
        }
    }
    
    /// Filters the assets based on the selected asset type, categories, price range & discounts and updates the `filteredAssets` property.
    func filterAssets() {
        let selectedCategories = assetsCategories.filter { $0.value }.map { $0.key.title }
        let selectedDiscounts = discountOptions.filter { $0.isOn }.map { $0.discount }
        
        filteredAssets = assets.filter { asset in
            let matchesType = asset.type == assetType.rawValue
            let matchesCategory = selectedCategories.isEmpty || selectedCategories.contains(asset.category)
            
            guard let price = Double(asset.price) else { return false }
            let matchesPrice = price >= 0 && price <= priceFilter
            
            let assetDiscount = Int(asset.discount ?? "") ?? 0
            let matchesDiscount = selectedDiscounts.isEmpty || selectedDiscounts.contains { $0 <= assetDiscount }
            
            return matchesType && matchesCategory && matchesPrice && matchesDiscount
        }
    }
    
    /// Filters the assets based on the user's search querys & optimized by using a debounce to delay of 0.5 seconds.
    func filterAssetsBySearch() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.filteredAssets = self?.assets.filter {
                    $0.title.lowercased().contains(text.lowercased()) || $0.description.lowercased().contains(text.lowercased())
                }
                ?? []
            }
            .store(in: &subscriptions)
    }
    
    /// Resets all filter criteria to their default values.
    func resetFilters() {
        priceFilter = 100
        assetType = .models
        
        for key in assetsCategories.keys {
            assetsCategories[key] = false
        }
        
        for index in discountOptions.indices {
            discountOptions[index].isOn = false
        }
    }
    
    /// Adds an asset to the user's cart.
    func addToCart(asset: Asset, modelContext: ModelContext) {
        SDService.shared.addToCart(asset: asset, modelContext: modelContext)
    }
    
    /// Handles the error by invoking an `alertPresenter` & initiates error description.
    func exceptionHandler(_ error: Error) {
        alertPresenter.toggle()
        alertDescription = error.localizedDescription
    }
}

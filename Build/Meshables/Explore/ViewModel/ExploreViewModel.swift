//
//  ExploreViewModel.swift
//  Meshables
//
//  Created by Aum Chauhan on 08/09/24.
//

import Combine
import SwiftUI

@MainActor
class ExploreViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var userProfiles: [UserProfile] = []
    @Published var filteredUserProfiles: [UserProfile] = []
    @Published var assets: [Asset] = []
    @Published var searchText: String = ""
    
    @Published var alertPresenter: Bool = false
    @Published var alertDescription: String = ""
    
    // MARK: - INITIALIZER
    
    init() {
        getUserProfiles()
        getAssets()
    }
    
    // MARK: - SERVICES
    
    /// Fetches the latest user profiles from the database and updates the `userProfiles` and `filteredUserProfiles` properties.
    func getUserProfiles() {
        Task {
            do {
                userProfiles = try await UserCredentials.shared.getAllUserProfiles()
                filteredUserProfiles = userProfiles
            } catch {
                exceptionHandler(error)
            }
        }
    }
    
    /// Fetches the latest assets from the database, filters out assets of type `.textures`, and updates the `assets` property.
    func getAssets() {
        Task {
            do {
                assets = try await AssetManagement.shared.getAssets()
                assets = assets.filter { $0.type != AssetType.textures.rawValue }
            } catch {
                exceptionHandler(error)
            }
        }
    }
    
    /// Filters the assets and user profiles based on the user's search querys & optimized by using a debounce to delay of 0.5 seconds.
    func filterUserProfiles() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.filteredUserProfiles = self?.userProfiles.filter {
                    $0.userName?.lowercased().contains(text.lowercased()) ?? false
                } ?? []
            }
            .store(in: &subscriptions)
    }
    
    /// Handles the error by invoking an `alertPresenter` & initiates error description.
    func exceptionHandler(_ error: Error) {
        alertPresenter.toggle()
        alertDescription = error.localizedDescription
        print(error.localizedDescription)
    }
}

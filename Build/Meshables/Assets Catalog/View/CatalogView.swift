//
//  CatalogView.swift
//  Meshables
//
//  Created by Aum Chauhan on 19/08/24.
//

import SwiftUI

/// Displays the catalog view for assets, including a picker for selecting asset types, a grid layout for assets, and a search bar.
struct CatalogView: View {
    
    // MARK: - PROPERTIES
    
    private let fixedColumn = [GridItem(.adaptive(minimum: 300))]
    
    @State private var isUploadSheetPresented: Bool = false
    @ObservedObject var viewModel: AssetsCatalogViewModel
    
    // MARK: - INITIALIZER
    
    init(shared: AssetsCatalogViewModel) {
        self.viewModel = shared
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    assetTypeOptions
                    assetCatalogGrid
                }
            }
            .safeAreaInset()
            .searchable(text: $viewModel.searchText, placement: .toolbar)
            
            .navigationTitle("Asset Catalog")
            .toolbar {
                ToolbarItem(placement: .bottomOrnament) {
                    toolbarContent
                }
            }
        }
        .animation(UIConstants.animationType, value: viewModel.filteredAssets)

        .sheet(isPresented: $isUploadSheetPresented) {
            UploadAssetView()
                .frame(width: 750, height: 750)
        }
    }
    
    // MARK: - ASSET TYPE OPTIONS
    
    private var assetTypeOptions: some View {
        ViewThatFits {
            assetTypePicker($viewModel.assetType)
                .pickerStyle(.palette)
            
            assetTypePicker($viewModel.assetType)
                .pickerStyle(.menu)
                .align(.leading)
        }
        .padding(.horizontal, UIConstants.standardContentPadding)
        .padding(.top, 5)
        .padding(.bottom, 20)
    }
    
    // MARK: - ASSET CATALOG GRID
    
    private var assetCatalogGrid: some View {
        LazyVGrid(columns: fixedColumn, spacing: UIConstants.standardContentPadding) {
            ForEach(viewModel.filteredAssets, id: \.self) { asset in
                NavigationLink {
                    AssetDetailsView(asset)
                } label: {
                    AssetCard(asset: asset, assetOwner: viewModel.assetOwnerDetails)
                        .padding(.horizontal, 8)
                }
                .buttonStyle(Custom())
            }
        }
        .padding(.horizontal, 20)
        .if(viewModel.filteredAssets.isEmpty) { _ in
            ContentUnavailableView(
                "No \(viewModel.assetType.title) Assets Available",
                systemImage: "folder.badge.questionmark",
                description: Text("Try selecting a different type, or upload your own to get started!")
            )
        }
    }
    
    // MARK: - TOOLBAR CONTENT
    
    private var toolbarContent: some View {
        HStack {
            Button("Upload", systemImage: "plus") {
                isUploadSheetPresented.toggle()
            }
            
            Divider()
            
            Button("Trade", systemImage: "arrow.left.arrow.right") {}
        }
        .labelStyle(.titleAndIcon)
    }
}

struct Custom: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .hoverEffectDisabled()
    }
}

#Preview {
    AssetCatalogView()
}

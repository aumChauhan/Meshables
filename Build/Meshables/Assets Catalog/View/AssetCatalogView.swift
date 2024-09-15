//
//  AssetCatalogView.swift
//  Meshables
//
//  Created by Aum Chauhan on 19/08/24.
//

import SwiftUI

/// Displays the main asset catalog view with a sidebar for filtering assets and a detailed catalog view.
struct AssetCatalogView: View {
    
    // MARK: - PROPERTIES
    
    @StateObject private var viewModel = AssetsCatalogViewModel()
    
    // MARK: - VIEW BODY
    
    var body: some View {
        NavigationSplitView {
            SidebarView(shared: viewModel)
        } detail: {
            CatalogView(shared: viewModel)
        }
        .onChange(of: viewModel.filterStates) {
            viewModel.filterAssets()
        }
        .animation(UIConstants.animationType, value: viewModel.filteredAssets)
        
        .alert(
            "Asset Access Failed",
            isPresented: $viewModel.alertPresenter,
            message: viewModel.alertDescription
        )
    }
}

#Preview {
    AssetCatalogView()
}

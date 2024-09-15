//
//  ExploreView.swift
//  Meshables
//
//  Created by Aum Chauhan on 20/08/24.
//

import SwiftUI

/// A view that serves as the main interface for exploring various assets and user profiles.
struct ExploreView: View {
    
    // MARK: - PROPERTIES
    
    private let fixedColumn = [GridItem(.adaptive(minimum: 300))]
    @StateObject private var viewModel = ExploreViewModel()
    
    // MARK: - VIEW BODY
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: UIConstants.compactVStackSpacing) {
                    userProfileList
                    
                    assetsList
                }
                .align(.leading)
                .if(viewModel.assets.isEmpty) { _ in
                    ProgressBar()
                        .align(.center)
                }
            }
            .padding(.horizontal, UIConstants.compactContentPadding)
            .searchable(text: $viewModel.searchText, prompt: Text("Search Users"))
            
            .navigationTitle("Explore")
        }
    }
    
    // MARK: - USER PROFILE LIST
    
    private var userProfileList: some View {
        Group {
            Text("Profiles")
                .primaryTitle()
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: UIConstants.standardHStackSpacing) {
                    ForEach(viewModel.filteredUserProfiles, id: \.self) { profile in
                        UserProfileCard(user: profile)
                            .padding(.trailing)
                            .materialBackdrop(.regularMaterial , padding: 15)
                    }
                }
                .padding(.bottom, 25)
                .if(viewModel.filteredUserProfiles.isEmpty) { _ in
                    Text("No User Found :(")
                        .primaryTitle()
                }
            }
        }
        .padding(.horizontal, 14)
    }
    
    // MARK: - ASSET LIST
    
    private var assetsList: some View {
        Group {
            Text("Assets")
                .primaryTitle()
            
            LazyVGrid(columns: fixedColumn, spacing: UIConstants.standardContentPadding) {
                ForEach(viewModel.assets, id: \.self) { asset in
                    AssetCard(asset: asset, assetOwner: nil)
                        .padding(.horizontal, 8)
                }
            }
        }
        .padding(.horizontal, 14)
    }
}

#Preview(windowStyle: .automatic) {
    ExploreView()
}

//
//  UserProfileView.swift
//  Meshables
//
//  Created by Aum Chauhan on 21/08/24.
//

import SwiftUI
import SwiftData

struct UserProfileView: View {
    
    // MARK: - PROPERTIES
    
    @Query(sort: \CartItem.title) var cartItems: [CartItem]
    @StateObject private var viewModel = UserProfileViewModel()
    @EnvironmentObject private var authenticationViewModel: AuthenticationViewModel
    
    // MARK: - VIEW BODY
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: UIConstants.standardVStackSpacing) {
                    userInfoGlimpse
                    followersList
                    assetsList
                    cartItemsList
                }
            }
            .padding(.horizontal, UIConstants.standardMargin)
            .safeAreaInset()
            
            .navigationTitle(viewModel.userInformation?.userName?.capitalized ?? "Unknown")
        }
        .task {
            viewModel.getFollowers(from: authenticationViewModel.userSession)
            viewModel.getUserInfo(from: authenticationViewModel.userSession)
            viewModel.getUserAssets(from: authenticationViewModel.userSession)
        }
    }
    
    // MARK: - USER INFO GLIMPSE
    
    private var userInfoGlimpse: some View {
        HStack {
            LazyImage(viewModel.userInformation?.profilePictureURL ?? GeneralUtilities.randomProfilePictureURL())
                .frame(width: 55, height: 55)
                .clipShape(Circle())
                .foregroundStyle(.regularMaterial.opacity(0.5))
            
            VStack(alignment: .leading) {
                Text(viewModel.userInformation?.userName?.capitalized ?? "Unknown")
                    .primaryTitle()
                
                HStack {
                    Text("\(viewModel.userInformation?.followers?.count ?? 0)  Followers")
                        .heading()
                    
                    StarRatingView(rating: Double(viewModel.userInformation?.rating ?? 5))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Button("Follow", systemImage: "person.fill") {
                viewModel.follow(to: "", from: authenticationViewModel.userSession?.uid ?? "")
            }
        }
    }
    
    // MARK: - FOLLOWERS LIST
    
    private var followersList: some View {
        SectionStack("Follwers") {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.followers, id: \.self) { userProfile in
                        UserProfileCard(user: userProfile)
                            .materialBackdrop(.regular)
                    }
                }
            }
            .if(viewModel.followers.isEmpty) { _ in
                Text("No Users Found")
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                    .align(.leading)
            }
        }
        
    }
    
    // MARK: - ASSETS LIST
    
    private var assetsList: some View {
        SectionStack("Assets") {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.assets, id: \.self) { asset in
                        AssetCard(asset: asset, assetOwner: nil)
                    }
                }
            }
            .if(viewModel.followers.isEmpty) { _ in
                Text("No Assets Found")
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                    .align(.leading)
            }
        }
    }
    
    // MARK: - CART ITEMS
    
    private var cartItemsList: some View {
        SectionStack("Cart Items") {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(cartItems, id: \.self) { cartItem in
                        cartItemCard(cartItem)
                    }
                }
            }
            .if(cartItems.isEmpty) { _ in
                Text("No Assets Found")
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                    .align(.leading)
            }
        }
    }
    
    // MARK: - CART ITEM CARD
    
    func cartItemCard(_ item: CartItem) -> some View {
        VStack(alignment: .leading, spacing: UIConstants.compactVStackSpacing) {
            LazyImage(item.thumbnail)
                .frame(minWidth: item.type == AssetType.textures.rawValue ? 200 : 250)
                .frame(height: item.type == AssetType.textures.rawValue ? 250 : 150)
                .borderRadius(UIConstants.compactCornerRadius)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(item.title.capitalized)
                    .heading()
                
                HStack {
                    if let discount = item.discount {
                        Price("\(GeneralUtilities.calculateDiscountedPrice(originalPrice: item.price, discountPercentage: discount) ?? "0")")
                            .primaryTitle()
                    }
                    
                    Price(item.price)
                        .strikethrough()
                        .foregroundStyle(.secondary)
                    
                    if let discount = item.discount {
                        Text("\(discount)% Off")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .lineLimit(1)
        .align(.leading)
        .materialBackdrop(.regularMaterial)
    }
}

#Preview {
    UserProfileView()
        .environmentObject(AuthenticationViewModel())
}

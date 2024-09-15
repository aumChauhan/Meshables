//
//  AssetCard.swift
//  Meshables
//
//  Created by Aum Chauhan on 19/08/24.
//

import SwiftUI

/// Represents an asset card for ``CatalogView``.
struct AssetCard: View {
    
    // MARK: - PROPERTIES
    
    let asset: Asset
    let assetOwner: UserProfile?
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = AssetsCatalogViewModel()
    @State private var isAddedToCart: Bool = false

    // MARK: - VIEW BODY
    
    var body: some View {
        VStack(alignment: .leading, spacing: UIConstants.compactVStackSpacing) {
            assetThumbnail
            
            VStack(alignment: .leading, spacing: 12) {
                assetTitleAndAuthor
                
                assetPrice
            }
        }
        .lineLimit(1)
        .align(.leading)
        .materialBackdrop(.regularMaterial)
        
        .alert("Item Added to Cart", isPresented: $isAddedToCart, message: "")
    }
    
    // MARK: - ASSET THUMBNAIL
    
    private var assetThumbnail: some View {
        LazyImage(asset.thumbnail)
            .frame(minWidth: asset.type == AssetType.textures.rawValue ? 200 : 250)
            .frame(height: asset.type == AssetType.textures.rawValue ? 250 : 150)
            .materialBackdrop(.ultraThick, cornerRadius: UIConstants.compactCornerRadius, padding: 0)
            .overlay(alignment: .topTrailing) {
                Image(systemName: "cart")
                    .padding()
                    .hoverEffect()
                    .onTapGesture {
                        viewModel.addToCart(asset: asset, modelContext: modelContext)
                        isAddedToCart.toggle()
                    }
            }
    }
    
    // MARK: - ASSET TITLE & AUTHOR
    
    private var assetTitleAndAuthor: some View {
        Group {
            Text(asset.title.capitalized)
                .heading()
            
            Text("by \(assetOwner?.userName?.capitalized ?? "CIA X KGB")")
                .subheading()
        }
    }
    
    // MARK: - ASSET PRICE
    
    private var assetPrice: some View {
        HStack {
            if let discount = asset.discount {
                Price("\(GeneralUtilities.calculateDiscountedPrice(originalPrice: asset.price, discountPercentage: discount) ?? "0")")
                    .primaryTitle()
            }
            
            Price(asset.price)
                .strikethrough()
                .foregroundStyle(.secondary)
            
            if let discount = asset.discount {
                Text("\(discount)% Off")
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    
}

#Preview {
    AssetCatalogView()
}

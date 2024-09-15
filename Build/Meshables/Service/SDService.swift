//
//  SDService.swift
//  Meshables
//
//  Created by Aum Chauhan on 14/09/24.
//

import SwiftUI
import SwiftData

/// `SDService` is responsible for handling operations related to swift data.
struct SDService {
    
    // MARK: - PROPERTIES
    
    static let shared = SDService()
    
    // MARK: - INITIALIZER
    
    private init() {}
    
    // MARK: - HELPER
    
    /// Adds an asset to the user's cart.
    func addToCart(asset: Asset, modelContext: ModelContext) {
        let cartItem = CartItem(
            title: asset.title,
            thumbnail: asset.thumbnail,
            is3d: asset.is3d,
            price: asset.price,
            category: asset.category,
            type: asset.type,
            tags: asset.tags
        )
        modelContext.insert(cartItem)
        try? modelContext.save()
    }
}

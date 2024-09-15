//
//  CartItem.swift
//  Meshables
//
//  Created by Aum Chauhan on 12/09/24.
//

import SwiftData
import Foundation

/// A model representing an item in a cart, including its unique identifier, name, and price.
@Model
class CartItem {
    var title: String
    var thumbnail: String
    var is3d: Bool
    var price: String
    var discount: String?
    var category: String
    var type: String
    var tags: [String]
    
    init(title: String, thumbnail: String, is3d: Bool, price: String, discount: String? = nil, category: String, type: String, tags: [String]) {
        self.title = title
        self.thumbnail = thumbnail
        self.is3d = is3d
        self.price = price
        self.discount = discount
        self.category = category
        self.type = type
        self.tags = tags
    }
}

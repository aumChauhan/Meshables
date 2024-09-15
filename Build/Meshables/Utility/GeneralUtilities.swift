//
//  GeneralUtilities.swift
//  Meshables
//
//  Created by Aum Chauhan on 08/09/24.
//

import Foundation

/// A utility class providing shared functions for various misc operations.
struct GeneralUtilities {
    
    /// Genrates randorm profile picture URL.
    static func randomProfilePictureURL() -> String {
        return "https://picsum.photos/id/\(Int.random(in: 10...210))/300/300"
    }
    
    /// Calculates the discounted price based on the original price and discount percentage, both provided as strings.
    static func calculateDiscountedPrice(originalPrice: String, discountPercentage: String) -> String? {
        guard let originalPriceDouble = Double(originalPrice),
              let discountPercentageDouble = Double(discountPercentage) else {
            return nil
        }
        
        let discountAmount = originalPriceDouble * (discountPercentageDouble / 100)
        let discountedPrice = originalPriceDouble - discountAmount
        
        return String(format: "%.2f", discountedPrice)
    }
}

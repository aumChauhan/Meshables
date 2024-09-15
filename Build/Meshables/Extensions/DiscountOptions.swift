//
//  DiscountOptions.swift
//  Meshables
//
//  Created by Aum Chauhan on 08/09/24.
//

extension AssetsCatalogViewModel {
    
    /// Define a struct for discount options conforming to Equatable.
    struct DiscountOption: Equatable {
        let title: String
        let discount: Int
        var isOn: Bool
    }
}


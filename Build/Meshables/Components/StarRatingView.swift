//
//  StarRatingView.swift
//  Meshables
//
//  Created by Aum Chauhan on 08/09/24.
//

import SwiftUI

import SwiftUI

/// A view that displays a star rating based on the provided rating value.
struct StarRatingView: View {
    
    // MARK: - PROPERTIES
    
    let rating: Double
    
    private var fullStars: Int {
        return Int(rating)
    }
    
    private var halfStar: Bool {
        return rating - Double(fullStars) >= 0.5
    }

    private var emptyStars: Int {
        return 5 - fullStars - (halfStar ? 1 : 0)
    }

    // MARK: - VIEW BODY
    
    var body: some View {
        HStack(spacing: 1) {
            ForEach(0..<fullStars, id: \.self) { _ in
                Image(systemName: "star.fill")
            }
            
            if halfStar {
                Image(systemName: "star.leadinghalf.fill")
            }
            
            ForEach(0..<emptyStars, id: \.self) { _ in
                Image(systemName: "star")
            }
        }
    }
}

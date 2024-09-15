//
//  UserProfileCard.swift
//  Meshables
//
//  Created by Aum Chauhan on 21/08/24.
//

import SwiftUI

/// Displays a card containing the user’s profile information, including their profile picture, username and rating.
struct UserProfileCard: View {
    
    // MARK: - PROPERTIES
    
    let user: UserProfile
    
    // MARK: - VIEW BODY
    
    var body: some View {
        HStack(spacing: 12) {
            LazyImage(user.profilePictureURL ?? GeneralUtilities.randomProfilePictureURL())
                .frame(width: 45, height: 45)
                .clipShape(Circle())
                .foregroundStyle(.regularMaterial.opacity(0.5))

            VStack(alignment: .leading, spacing: 8) {
                Text(user.userName?.capitalized ?? "Unknown")
                    .heading()
                
                HStack {
                    StarRatingView(rating: Double(user.rating ?? 5))
                    
                    Text("\(user.ratingCount ?? 10)")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
    }
}

//
//  UserProfile.swift
//  Meshables
//
//  Created by Aum Chauhan on 21/08/24.
//

import Foundation

/// Represents a user profile with associated details such as email, followers, profile picture, UID, and username.
struct UserProfile: Codable, Hashable {
    let uid: String
    let userName: String?
    let email: String?
    let profilePictureURL: String?
    let followers: [String]?
    let purchasedItems: [String]?
    let rating: Int?
    let ratingCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case uid
        case userName = "username"
        case email
        case profilePictureURL = "profilePic"
        case followers
        case purchasedItems
        case rating
        case ratingCount = "rating_count"
    }
}

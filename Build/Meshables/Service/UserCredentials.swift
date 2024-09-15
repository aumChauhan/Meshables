//
//  UserCredentials.swift
//  Meshables
//
//  Created by Aum Chauhan on 03/09/24.
//

import Foundation
import FirebaseFirestore

/// Handles user profile data operations in Firebase Firestore.
struct UserCredentials {
    
    // MARK: - PROPERTIES
    
    static let shared = UserCredentials()
    
    // MARK: - INITIALIZER
    
    private init(){}
    
    // MARK: - USER SERVICE
    
    /// Saves user profile data to the Firestore 'Profiles' collection.
    func setUserCredentials(user: UserProfile) throws {
        try FirebaseCollections.profiles
            .document(user.uid)
            .setData(from: user, merge: false)
    }
    
    /// Retrieves the user profile data for a given user ID from the Firebase collection.
    func getUserCredentials(from userID: String) async throws -> UserProfile {
        return try await FirebaseCollections.profiles
            .document(userID)
            .getDocument(as: UserProfile.self)
    }
    
    /// Retrieves all list of user profiles from the Firestore 'Profiles' collection
    func getAllUserProfiles() async throws -> [UserProfile] {
        return try await FirebaseCollections.profiles
            .getDocuments(as: UserProfile.self)
    }
    
    /// Updates the `followers` field of a user profile by appending the current user's ID.
    func follow(to userUID: String, currentUserUID: String) async throws {
        try await FirebaseCollections.profiles.document(userUID)
            .updateData(
                ["followers": FieldValue.arrayUnion([currentUserUID])]
            )
    }
}


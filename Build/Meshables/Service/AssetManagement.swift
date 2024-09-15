//
//  AssetManagement.swift
//  Meshables
//
//  Created by Aum Chauhan on 06/09/24.
//

import Foundation

/// Manages database operations related to assets in Firebase.
struct AssetManagement {
    
    // MARK: - PROPERTIES
    
    static let shared = AssetManagement()
    
    // MARK: - INITIALIZER
    
    private init() {}
    
    // MARK: - ASSET SERVICE
    
    /// Retrieves a list of assets from the Firebase 'Assets' collection.
    func getAssets() async throws -> [Asset] {    
        return try await FirebaseCollections.assets
            .getDocuments(as: Asset.self)
    }
    
    /// Retrieves assets associated with a specific user ID from Firebase 'Assets' collection.
    func getAssets(from userId: String) async throws -> [Asset] {
        return try await FirebaseCollections.assets
            .whereField("userId", isEqualTo: userId)
            .getDocuments(as: Asset.self)
    }
}

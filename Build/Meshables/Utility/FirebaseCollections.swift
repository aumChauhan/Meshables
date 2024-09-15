//
//  FirebaseCollections.swift
//  Meshables
//
//  Created by Aum Chauhan on 03/09/24.
//

import Foundation
import FirebaseFirestore

/// Holds references to Firebase Firestore collections.
struct FirebaseCollections {
    
    /// Reference to the 'Profiles' collection in Firestore.
    /// ```
    /// Firestore.firestore().collection("Profiles")
    /// ```
    static let profiles = Firestore.firestore().collection("Profiles")   
    
    /// Reference to the 'Assets' collection in Firestore.
    /// ```
    /// Firestore.firestore().collection("Assets")
    /// ```
    static let assets = Firestore.firestore().collection("Assets")
}

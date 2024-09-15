//
//  Authentication.swift
//  Meshables
//
//  Created by Aum Chauhan on 03/09/24.
//

import Foundation
import FirebaseAuth

// Manages network calls for authentication processes in Firebase
struct Authentication {
    
    // MARK: - PROPERTIES

    static let shared = Authentication()
    
    // MARK: - INITIALIZER
    
    private init() {}
    
    // MARK: -  AUTHENTICATION SERVICES
    
    /// Registers a new user with the provided email and password.
    func signUp(emailId: String, password: String) async throws -> AuthDataResult {
        return try await Auth.auth()
            .createUser(withEmail: emailId, password: password)
    }
    
    /// Logs in the user with the provided email and password.
    func signIn(withEmail email: String, password: String) async throws -> AuthDataResult {
        return try await Auth.auth()
            .signIn(withEmail: email, password: password)
    }
    
    /// Signs out the current user.
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    /// Sends a verification email to the current user.
    func emailVerification() async throws {
        try await Auth.auth()
            .currentUser?.sendEmailVerification()
    }
    
    /// Returns the currently authenticated user.
    func currentSession() -> User? {
        return Auth.auth().currentUser
    }
    
    /// Sends a password reset email to the provided email address.
    func resetPassword(email: String) async throws {
        try await Auth.auth()
            .sendPasswordReset(withEmail: email)
    }
}

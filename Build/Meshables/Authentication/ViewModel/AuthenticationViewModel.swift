//
//  AuthenticationViewModel.swift
//  Meshables
//
//  Created by Aum Chauhan on 03/09/24.
//

import SwiftUI
import FirebaseAuth

/// Manages user authentication state and operations, including sign-up, sign-in, sign-out, email verification, and password reset.
@MainActor
class AuthenticationViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    @Published var userName: String = ""
    @Published var emailAddress: String = ""
    @Published var password: String = ""
    @Published var authenticationAction: AuthenticationAction = .signUp
    
    @Published var alertPresenter: Bool = false
    @Published private(set) var alertDescription: String = ""
    @Published private(set) var isLoading: Bool = false
    
    @Published var userSession: FirebaseAuth.User?
    
    // MARK: - INITIALIZER
    
    init() {
        self.userSession = Authentication.shared.currentSession()
    }
    
    // MARK: - SERVICES
    
    /// Signs up a user with the provided email and password, then creates a user profile in Firestore.
    func createUserProfile() {
        Task {
            do {
                isLoading = true
                
                guard IntegrityConstraints.isNameProperlyFormatted(userName) else {
                    throw Exceptions.invalidUsername
                }
                
                guard IntegrityConstraints.isEmailProperlyFormatted(emailAddress) else {
                    throw Exceptions.invalidEmailAddress
                }
                
                let temporarySession = try await Authentication.shared.signUp(emailId: emailAddress, password: password)
                userSession = temporarySession.user
                
                guard let userSession else { return }
                
                let userProfile = UserProfile(
                    uid: userSession.uid,
                    userName: userName,
                    email: emailAddress,
                    profilePictureURL: GeneralUtilities.randomProfilePictureURL(),
                    followers: [],
                    purchasedItems: [],
                    rating: 0,
                    ratingCount: 0
                )
                
                try UserCredentials.shared.setUserCredentials(user: userProfile)
                
                isLoading = false
            } catch {
                exceptionHandler(error)
                isLoading = false
            }
        }
    }
    
    /// Initiates the sign-in process with email and password.
    func signIn() {
        Task {
            do {
                isLoading = true
                
                guard IntegrityConstraints.isEmailProperlyFormatted(emailAddress) else {
                    throw Exceptions.invalidEmailAddress
                }
                
                let temporarySession = try await Authentication.shared.signIn(withEmail: emailAddress, password: password)
                userSession = temporarySession.user
                
                isLoading = false
            } catch {
                exceptionHandler(error)
                isLoading = false
            }
        }
    }
    
    /// Signs out the user and sets current `userSession` to nil.
    func signOut() {
        do {
            isLoading = true
            
            try Authentication.shared.signOut()
            userSession = nil
            
            isLoading = false
        } catch {
            exceptionHandler(error)
            isLoading = false
        }
    }
    
    /// Resets all text fields to their default empty state.
    func resetTextfields() {
        userName = String()
        emailAddress = String()
        password = String()
    }
    
    /// Initiates a password reset process for the provided email address.
    func resetPassword() {
        Task {
            do {
                try await Authentication.shared.resetPassword(email: emailAddress)
            } catch {
                exceptionHandler(error)
            }
        }
    }
    
    /// Checks if there is an active user session.
    func isSessionActive() -> Bool {
        return userSession != nil
    }
    
    /// Determines whether the current `authenticationAction` is set to sign up.
    func isSigningUp() -> Bool {
        authenticationAction == .signUp
    }
    
    /// Handles the error by invoking an `alertPresenter` & initiates error description.
    func exceptionHandler(_ error: Error) {
        alertPresenter.toggle()
        alertDescription = error.localizedDescription
    }
}

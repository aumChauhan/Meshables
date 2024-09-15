//
//  UserProfileViewModel.swift
//  Meshables
//
//  Created by Aum Chauhan on 12/09/24.
//

import Foundation
import FirebaseAuth

@MainActor
class UserProfileViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    @Published var assets: [Asset] = []
    @Published var cartItem: [CartItem] = []
    @Published var followers: [UserProfile] = []
    @Published var userInformation: UserProfile?
    
    // MARK: - HELPER
    
    /// Retrieves the assets associated with the currently authenticated user.
    func getUserAssets(from userSession: FirebaseAuth.User?) {
        Task {
            do {
                guard let userSession else {
                    throw URLError(.userAuthenticationRequired)
                }
                assets = try await AssetManagement.shared.getAssets(from: userSession.uid)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Retrieves the followers associated with the currently authenticated user.
    func getFollowers(from userSession: FirebaseAuth.User?) {
        Task {
            do {
                guard let userSession else {
                    throw URLError(.userAuthenticationRequired)
                }
                print(userSession.uid)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Retrieves user information based on the authenticated user's session.
    func getUserInfo(from userSession: FirebaseAuth.User?) {
        Task {
            do {
                guard let userSession else {
                    throw URLError(.userAuthenticationRequired)
                }
                userInformation = try await UserCredentials.shared.getUserCredentials(from: userSession.uid)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Follows a user by appending the current user's UID to the specified user's followers list.
    func follow(to userUID : String, from user: String) {
        Task {
            do {
                try await UserCredentials.shared.follow(to: userUID, currentUserUID: user)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

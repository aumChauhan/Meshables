//
//  AuthenticationAction.swift
//  Meshables
//
//  Created by Aum Chauhan on 02/09/24.
//

import Foundation

/// Represents the different authentication actions available in the app.
@frozen
enum AuthenticationAction: String, CaseIterable {
    case signUp = "Sign Up"
    case signIn = "Sign In"
}

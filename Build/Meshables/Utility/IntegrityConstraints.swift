//
//  IntegrityConstraints.swift
//  Meshables
//
//  Created by Aum Chauhan on 03/09/24.
//

import Foundation

/// Handles data validation tasks ensuring that mainatains integrity constraints
struct IntegrityConstraints {
    
    /// Checks if the given name is in valid format.
    static func isNameProperlyFormatted(_ username: String) -> Bool {
        let fullNameCharacterSet = CharacterSet(charactersIn: username)
        let allowedCharacterSet = CharacterSet.letters.union(.whitespaces)
        
        // Check if the full name contains only allowed characters (letters and whitespaces)
        guard allowedCharacterSet.isSuperset(of: fullNameCharacterSet) else {
            return false
        }
        
        // Check if the full name contains text and not just blank spaces
        let trimmedFullName = username.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedFullName.isEmpty else {
            return false
        }
        
        return true
    }
    
    /// Verifies if the provided email address is in a valid format.
    static func isEmailProperlyFormatted(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
}

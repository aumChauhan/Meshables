//
//  ExceptionsDescription.swift
//  Meshables
//
//  Created by Aum Chauhan on 03/09/24.
//

import Foundation

extension Exceptions: LocalizedError {
    
    /// Provides a user-friendly description for each exception case.
    var errorDescription: String? {
        switch self {
        case .invalidUsername:
            return NSLocalizedString("The username you entered is invalid. Please ensure it contains only letters and spaces, and try again.", comment: "InvalidUsername")
        case .invalidEmailAddress:
            return NSLocalizedString("The email address you provided is not in a valid format. Please check for any typos and try again.", comment: "InvalidEmailAddress")
        }
    }
}

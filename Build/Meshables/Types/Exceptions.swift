//
//  Exceptions.swift
//  Meshables
//
//  Created by Aum Chauhan on 03/09/24.
//

import Foundation

/// An enum representing custom error types for validation.
@frozen
enum Exceptions: Error {
    case invalidUsername
    case invalidEmailAddress
}

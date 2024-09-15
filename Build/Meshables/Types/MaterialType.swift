//
//  MaterialType.swift
//  Meshables
//
//  Created by Aum Chauhan on 11/09/24.
//

import SwiftUI

/// An enumeration representing different types of materials used in SwiftUI views.
@frozen
enum MaterialType: String, CaseIterable, Hashable {
    case ultraThin
    case thin
    case regular
    case thick
    case ultraThick
    
    var material: SwiftUI.Material {
        switch self {
        case .ultraThin:
            return .ultraThinMaterial
        case .thin:
            return .thinMaterial
        case .regular:
            return .regularMaterial
        case .thick:
            return .thickMaterial
        case .ultraThick:
            return .ultraThickMaterial
        }
    }
}

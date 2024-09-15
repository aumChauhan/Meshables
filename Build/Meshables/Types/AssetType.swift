//
//  AssetType.swift
//  Meshables
//
//  Created by Aum Chauhan on 19/08/24.
//

import Foundation

/// Represents various categories of assets available in the Meshables marketplace.
@frozen
enum AssetType: String, CaseIterable {
    case models = "models"
    case textures = "textures"
    case scripts = "scripts"
    case printable = "printable"
    case shaders = "shaders"
    case plugins = "plugins"
    case hdris = "HDRIs"
    
    /// Title associated with each category.
    var title: String {
        switch self {
        case .printable:
            return "Printable"
        case .models:
            return "3D Models"
        case .textures:
            return "Textures"
        case .scripts:
            return "Scripts"
        case .shaders:
            return "Shaders"
        case .plugins:
            return "Plugins"
        case .hdris:
            return "HDRIs"
        }
    }
    
    /// SF Symbol name associated with each category.
    var sfSymbol: String {
        switch self {
        case .printable:
            return "printer.fill"
        case .models:
            return "cube.fill"
        case .textures:
            return "photo"
        case .scripts:
            return "doc.text.fill"
        case .shaders:
            return "paintbrush.fill"
        case .plugins:
            return "puzzlepiece.extension.fill"
        case .hdris:
            return "sun.max.fill"
        }
    }
}

//
//  AssetCategory.swift
//  Meshables
//
//  Created by Aum Chauhan on 20/08/24.
//

import Foundation

/// Enum representing various asset categories, each associated with a title and SF symbol.
@frozen
enum AssetCategory: CaseIterable, Identifiable {
    case livingRoom
    case kitchen
    case outdoor
    case office
    case sports
    case electronics
    
    /// The unique identifier for each category, useful for identifying items in a list.
    var id: String { title }
    
    /// The display title for each asset category.
    var title: String {
        switch self {
        case .livingRoom: return "Living Room"
        case .kitchen: return "Kitchen"
        case .outdoor: return "Outdoor"
        case .office: return "Office"
        case .sports: return "Sports"
        case .electronics: return "Electronics"
        }
    }
    
    /// The SF symbol name associated with each asset category for visual representation.
    var sfSymbol: String {
        switch self {
        case .livingRoom: return "house.fill"
        case .kitchen: return "fork.knife"
        case .outdoor: return "leaf.fill"
        case .office: return "briefcase.fill"
        case .sports: return "sportscourt"
        case .electronics: return "tv.fill"
        }
    }
}

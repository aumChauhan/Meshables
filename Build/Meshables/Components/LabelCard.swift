//
//  LabelCard.swift
//  Meshables
//
//  Created by Aum Chauhan on 21/08/24.
//

import SwiftUI

/// Displays a labeled card with an icon and text, typically used in settings or similar interfaces.
struct LabelCard: View {
    
    // MARK: - PROPERTIES
    
    let titleKey: String
    let systemImage: String
    
    // MARK: - INITIALIZER
    
    init(_ titleKey: String, systemImage: String) {
        self.titleKey = titleKey
        self.systemImage = systemImage
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        HStack(spacing: UIConstants.standardHStackSpacing) {
            Circle()
                .frame(width: 40)
                .foregroundStyle(.ultraThinMaterial)
                .overlay {
                    Image(systemName: systemImage)
                }
            
            Text(titleKey)
                .heading()
        }
    }
}

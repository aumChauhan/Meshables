//
//  TextBox.swift
//  Meshables
//
//  Created by Aum Chauhan on 02/09/24.
//

import SwiftUI

/// A customizable text box with an optional secure field and an icon.
struct TextBox: View {
    
    // MARK: - PROPERTIES
    
    let placeholder: String
    var isSecure: Bool = false
    let systemImage: String
    @Binding var text: String
    
    // MARK: - VIEW BODY

    var body: some View {
        HStack(spacing: UIConstants.standardHStackSpacing) {
            Image(systemName: systemImage)
                .font(.callout)
                .foregroundStyle(.secondary)
                .padding(.leading, 5)
            if isSecure {
                SecureField(placeholder, text: $text)
                    .hoverEffectDisabled()
            } else {
                TextField(placeholder, text: $text)
                    .hoverEffectDisabled()
            }
        }
        .materialBackdrop(.regularMaterial, cornerRadius: .infinity, padding: 14)
        .hoverEffect(.highlight)
        .borderRadius(.infinity)
    }
}

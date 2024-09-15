//
//  StretchedButton.swift
//  Meshables
//
//  Created by Aum Chauhan on 19/08/24.
//

import SwiftUI

/// A Custom button that stretches to fill its container, optionally displaying a system image or a custom image alongside a title.
struct StretchedButton: View {
    
    // MARK: - PROPERTIES
    
    let titleKey: String
    let systemImage: String?
    let imageName: String?
    let action: () -> Void
    
    // MARK: - INITIALIZER
    
    init(titleKey: String, systemImage: String? = nil, imageName: String? = nil, action: @escaping () -> Void) {
        self.titleKey = titleKey
        self.systemImage = systemImage
        self.imageName = imageName
        self.action = action
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: UIConstants.standardHStackSpacing) {
                if let imageName {
                    Image(imageName)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.title3)
                }
                
                Text(titleKey)
                    .font(.body)
            }
            .padding(UIConstants.compactContentPadding)
            .frame(maxWidth: .infinity)
        }
    }
}

//
//  ViewElements.swift
//  Meshables
//
//  Created by Aum Chauhan on 20/08/24.
//

import SwiftUI

extension View {
    
    /// Creates a cell view to display features in ``GreetingView`` with an icon, title, and description.
    func featureCell(systemImage: String, titleKey: String, description: String) -> some View {
        HStack(alignment: .top, spacing: UIConstants.standardHStackSpacing) {
            Image(systemName: systemImage)
                .font(.body)
                .padding()
                .background(.ultraThinMaterial)
                .borderRadius(.infinity)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(titleKey)
                    .primaryTitle()
                
                Text(description)
                    .secondaryTitle()
                    .lineLimit(4)
            }
        }
    }
    
    /// Provides a picker for selecting asset types with labels and icons.
    func assetTypePicker(_ selection: Binding<AssetType>) -> some View {
        Picker("Asset Type", selection: selection) {
            ForEach(AssetType.allCases, id: \.self) { item in
                Label(item.title, systemImage: item.sfSymbol)
                    .labelStyle(.titleAndIcon)
                    .tag(item)
            }
        }
    }
    
    /// Displays a view with a large icon and a title button for file selection within the Upload Asset sheet.
    func fileSelectionView(systemImage: String, title: String, action: @escaping () -> Void) -> some View {
        VStack(spacing: UIConstants.compactVStackSpacing) {
            Image(systemName: systemImage)
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            
            Button(title, action: action)
                .secondaryTitle()
        }
        .padding()
        .align(.center)
    }
}

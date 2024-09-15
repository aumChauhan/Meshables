//
//  Checkbox.swift
//  Meshables
//
//  Created by Aum Chauhan on 19/08/24.
//

import SwiftUI

/// Represents a checkbox with a title and binding to a boolean state, supporting hover effects.
struct Checkbox: View {
    
    // MARK: - PROPERTIES
    
    private let titleKey: String
    @Binding private var isOn: Bool
    
    @State private var isInHoverState: Bool = false
    
    // MARK: - INITIALIZERS
    
    init(_ titleKey: String, isOn: Binding<Bool>) {
        self.titleKey = titleKey
        self._isOn = isOn
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        Toggle(titleKey, isOn: $isOn)
            .labelsHidden()
            .toggleStyle(CheckboxStyle())
    }
}

// MARK: - STYLE

/// Defines a custom toggle style for checkboxes.
struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .align(.leading)
            
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .font(.title2)
                .foregroundStyle(configuration.isOn ? .primary : .secondary)
                .hoverEffect()
                .onTapGesture {
                    configuration.isOn.toggle()
                }
                .animation(UIConstants.animationType, value: configuration.isOn)
        }
        .listRowHoverEffect(HoverEffect.highlight)
    }
}

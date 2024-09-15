//
//  ViewModifiers.swift
//  Meshables
//
//  Created by Aum Chauhan on 19/08/24.
//

import SwiftUI

extension View {
    
    /// Applies a primary title style to the text view.
    func primaryTitle() -> some View {
        self
            .font(.title3)
            .foregroundStyle(.primary)
    }
    
    /// Applies a secondary title style to the text view.
    func secondaryTitle() -> some View {
        self
            .font(.body)
            .fontWeight(.medium)
            .foregroundStyle(.secondary)
    }
    
    /// Applies a header title style to the text view.
    func heading() -> some View {
        self
            .font(.body)
            .fontWeight(.semibold)
            .foregroundStyle(.primary)
    }
    
    /// Applies a subheader title style to the text view.
    func subheading() -> some View {
        self
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }
    
    /// Applies a rounded rectangle shape as a clipping mask to the view with a specified corner radius.
    func borderRadius(_ radius: CGFloat) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: radius))
    }
    
    /// Creates a tab bar item with a system image and a title.
    func tabBarItem(systemImage: String, _ titleKey: String) -> some View {
        self
            .tabItem {
                Image(systemName: systemImage)
                Text(titleKey)
            }
    }
    
    /// Conditionally applies a view transformation based on a Boolean condition.
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Creates a navigation header with a navigation title and toolbar content.
    func navigationHeader(title navigationTitle: String, @ToolbarContentBuilder toolbar: () -> some ToolbarContent) -> some View {
        self
            .navigationTitle(navigationTitle)
            .toolbar {
                toolbar()
            }
    }
    
    /// Applies a customizable material background, and rounded corners to the view.
    func materialBackdrop(_ material: Material? = nil, cornerRadius: CGFloat? = nil, padding: CGFloat? = nil) -> some View {
        self
            .padding(padding ?? UIConstants.compactContentPadding)
            .background(material ?? .thinMaterial)
            .borderRadius(cornerRadius ?? UIConstants.cornerRadius)
    }
    
    /// Adds an alert to the view with a specified title, presentation binding, and message.
    func alert(_ titleKey: String, isPresented: Binding<Bool>, message: String) -> some View {
        self
            .alert(titleKey, isPresented: isPresented) {} message: {
                Text(message)
            }
    }
    
    /// Adds a safe area inset to the bottom of the view.
    func safeAreaInset() -> some View {
        self
            .safeAreaInset(edge: .bottom) {
                Text("")
                    .padding(UIConstants.compactContentPadding)
            }
    }
    
    /// Aligns the view within its frame based on the specified alignment option.
    @ViewBuilder
    func align(_ at: Alignment) -> some View {
        switch at {
        case .top:
            self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        case .bottom:
            self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        case .leading:
            self.frame(maxWidth: .infinity, alignment: .leading)
        case .trailing:
            self.frame(maxWidth: .infinity, alignment: .trailing)
        case .topLeading:
            self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        case .topTrailing:
            self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        case .bottomLeading:
            self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        case .bottomTrailing:
            self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        case .center:
            self.frame(maxWidth: .infinity, alignment: .center)
        default:
            self.frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

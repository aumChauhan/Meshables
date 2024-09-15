//
//  SectionStack.swift
//  Meshables
//
//  Created by Aum Chauhan on 11/09/24.
//

import SwiftUI

/// A reusable view that arranges a title and content vertically with leading alignment.
struct SectionStack<Content: View>: View {
    
    // MARK: - PROPERTIES
    
    let title: String
    let content: Content
    
    // MARK: - INITIALIZER
    
    init(_ titleKey: String, @ViewBuilder content: () -> Content) {
        self.title = titleKey
        self.content = content()
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        VStack(alignment: .leading, spacing: UIConstants.compactVStackSpacing) {
            Text(title)
                .primaryTitle()
            
            content
        }
    }
}

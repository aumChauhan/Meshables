//
//  FlowLayout.swift
//  Meshables
//
//  Created by Aum Chauhan on 12/09/24.
//

import SwiftUI

/// A layout that arranges its children in a horizontal flow, wrapping them onto new rows as necessary.
struct FlowLayout<Data, ID, RowContent>: View where Data: RandomAccessCollection, RowContent: View, Data.Element: Hashable, ID : Hashable  {
    
    // MARK: - PROPERTIES
    
    @State private var height: CGFloat = .zero
    
    private var data: Data
    private var id: KeyPath<Data.Element, ID>
    private var spacing: CGFloat
    private var rowContent: (Data.Element) -> RowContent
    
    // MARK: - INITIALIZER
    
    init(_ data: Data , _ id: KeyPath<Data.Element, ID> , spacing: CGFloat = 4, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent) {
        self.data = data
        self.spacing = spacing
        self.rowContent = rowContent
        self.id = id
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        GeometryReader { geometry in
            content(in: geometry)
                .background(viewHeight(for: $height))
        }
        .frame(height: height)
    }
    
    // MARK: - CONTENT
    
    private func content(in geometry: GeometryProxy) -> some View {
        var bounds = CGSize.zero
        
        return ZStack {
            ForEach(data, id: id) { item in
                rowContent(item)
                    .padding(.all, spacing)
                    .alignmentGuide(VerticalAlignment.center) { dimension in
                        let result = bounds.height
                        
                        if let firstItem = data.first, item == firstItem {
                            bounds.height = 0
                        }
                        return result
                    }
                    .alignmentGuide(HorizontalAlignment.center) { dimension in
                        if abs(bounds.width - dimension.width) > geometry.size.width {
                            bounds.width = 0
                            bounds.height -= dimension.height
                        }
                        
                        let result = bounds.width
                        
                        if let firstItem = data.first, item == firstItem {
                            bounds.width = 0
                        } else {
                            bounds.width -= dimension.width
                        }
                        return result
                    }
            }
        }
    }
    
    // MARK: - VIEW HEIGHT
    
    private func viewHeight(for binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

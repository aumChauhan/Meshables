//
//  SidebarView.swift
//  Meshables
//
//  Created by Aum Chauhan on 19/08/24.
//

import SwiftUI

/// Displays a sidebar with filtering options for asset categories, price, and discounts.
struct SidebarView: View {
    
    // MARK: - PROPERTIES
    
    @ObservedObject var viewModel: AssetsCatalogViewModel
    
    // MARK: - INITIALIZER
    
    init(shared: AssetsCatalogViewModel) {
        self.viewModel = shared
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        List {
            categoryOptions
            priceRange
            discountOptions
        }
        .listStyle(.grouped)
        .listSectionSpacing(.compact)
        
        .navigationTitle("Filter Options")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - CATEGORY OPTIONS
    
    private var categoryOptions: some View {
        Section("Category") {
            ForEach(AssetCategory.allCases, id: \.self) { category in
                Checkbox(category.title, isOn: Binding(
                    get: { viewModel.assetsCategories[category] ?? false },
                    set: { newValue in viewModel.assetsCategories[category] = newValue }
                ))
            }
        }
    }
    
    // MARK: - PRICE RANGE
    
    private var priceRange: some View {
        Section("Price Range") {
            VStack(spacing: UIConstants.compactVStackSpacing) {
                Slider(value: $viewModel.priceFilter, in: 0...150)
                
                HStack() {
                    Price("0")
                    Spacer()
                    Price($viewModel.priceFilter)
                }
                .fontWeight(.bold)
            }
        }
    }
    
    // MARK: - DISCOUNT OPTIONS
    
    private var discountOptions: some View {
        Section("Discount") {
            ForEach(0..<viewModel.discountOptions.count, id: \.self) { index in
                Checkbox(viewModel.discountOptions[index].title, isOn: $viewModel.discountOptions[index].isOn)
            }
            
            Button("Clear All Filters") {
                viewModel.resetFilters()
            }
            .fontWeight(.medium)
            .tint(.blue)
        }
    }
}

#Preview {
    AssetCatalogView()
}

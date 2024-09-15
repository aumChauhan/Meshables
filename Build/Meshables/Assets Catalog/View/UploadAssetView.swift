//
//  UploadAssetView.swift
//  Meshables
//
//  Created by Aum Chauhan on 20/08/24.
//

import SwiftUI

/// Represents a view for uploading assets, allowing users to submit new 3D(or 2D) assets.
struct UploadAssetView: View {
    
    // MARK: - PROPERTIES
    
    @State private var is3D: Bool = true
    @State private var isFileImporterPresent: Bool = false
    @State private var assetType: AssetType = .models
    @State private var assetCategory: AssetCategory = .sports
    
    @Environment(\.dismiss) private var dismiss

    // MARK: - VIEW BODY
    
    var body: some View {
        NavigationStack {
            Form {
                // Title, Description & Thumbnail URL
                Section("Asset Details") {
                    TextField("Title", text: .constant(""))
                    
                    TextField("Description", text: .constant(""))
                    
                    TextField("Thumbnail URL", text: .constant(""))
                        .textContentType(.URL)
                }
                
                // Asset Type, Category& is 3D
                Section("Types & Category") {
                    assetTypePicker($assetType)
                    
                    Picker("Asset Category", selection: $assetCategory) {
                        ForEach(AssetCategory.allCases) { item in
                            Label(item.title, systemImage: item.sfSymbol)
                                .labelStyle(.titleAndIcon)
                                .tag(item)
                        }
                    }
                    
                    Toggle("Is this asset a 3D model?", isOn: $is3D)
                }
                .fontWeight(.semibold)
                .pickerStyle(.navigationLink)
                .buttonStyle(.plain)
                
                // Price & Discount
                Section("Price & Discount") {
                    TextField("Price (USD)", text: .constant(""))
                        .textContentType(.telephoneNumber)
                    
                    TextField("Discount", text: .constant(""))
                        .textContentType(.telephoneNumber)
                }
                
                // File Selection View
                Section(is3D ? "Model" : "Image") {
                    fileSelectionView(systemImage: "move.3d", title: "Select a Model") {
                        isFileImporterPresent.toggle()
                    }
                    // Incase Of Image
                    .if(!is3D) { view in
                        fileSelectionView(systemImage: "photo", title: "Select an Image") {
                            isFileImporterPresent.toggle()
                        }
                    }
                }
                
                // 3D Model Meta Data
                if is3D {
                    Section("Meta Data") {
                        TextField("Resolution", text: .constant(""))
                        
                        TextField("Physical Size", text: .constant(""))
                        
                        TextField("LODs", text: .constant(""))
                            .textContentType(.telephoneNumber)
                        
                        TextField("Vertices", text: .constant(""))
                            .textContentType(.telephoneNumber)
                    }
                }
            }
            .listSectionSpacing(.compact)
            
            // File Importer
            .fileImporter(isPresented: $isFileImporterPresent, allowedContentTypes: is3D ? [.usdz] : [.jpeg, .png]) {
                result in
            }
            
            // Nav Title & Toolbar
            .navigationHeader(title: "Upload Asset") {
                // Dismisses Sheet
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Dismiss", systemImage: "xmark") {
                        dismiss()
                    }
                }
                
                // Upload's Asset
                ToolbarItem(placement: .bottomOrnament) {
                    Button("Upload", systemImage: "plus") {}
                        .labelStyle(.titleAndIcon)
                        .heading()
                }
            }
        }
    }
}

#Preview {
    UploadAssetView()
}

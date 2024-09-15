//
//  AssetDetailsView.swift
//  Meshables
//
//  Created by Aum Chauhan on 08/09/24.
//

import SwiftUI
import RealityKit

struct AssetDetailsView: View {
    
    // MARK: - PROPERTIES
    
    let asset: Asset
    @Environment(\.openWindow) private var openWindow
    @State private var selectedMaterial: MaterialType = .regular
    @State private var expandDescriptionLineLimit: Bool = false
    
    // MARK: - INITIALIZER
    
    init(_ asset: Asset) {
        self.asset = asset
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        GeometryReader { geometry in
            let columns: [GridItem] = geometry.size.width > 750 ? [GridItem(.flexible()), GridItem(.flexible())] : [GridItem(.flexible())]
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: UIConstants.standardContentPadding) {
                    VStack(spacing: UIConstants.standardVStackSpacing) {
                        modelPreview
                        assetPriceInformation
                        assetDescription
                    }
                    
                    VStack(spacing: UIConstants.standardVStackSpacing) {
                        assetDetials
                        assetTags
                    }
                    .align(.topLeading)
                    .padding(.leading, geometry.size.width > 750 ? UIConstants.standardContentPadding : 0)
                }
            }
            .padding(.horizontal, UIConstants.standardMargin)
        }
        .safeAreaInset()
        .navigationTitle("Asset Information")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if let url = asset.usdzURL {
                        openWindow(id: "asset", value: url)
                    }
                } label: {
                    Image(systemName: "move.3d")
                    Text("Explore in AR")
                }
            }
        }
    }
    
    // MARK: - MODEL PREVIEW
    
    private var modelPreview: some View {
        VStack {
            materialPicer
                .align(.leading)
            
            if let url = asset.usdzURL {
                Model3DViewer(url)
                    .scaleEffect(0.09)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 350, maxHeight: 400)
        .materialBackdrop(selectedMaterial.material, padding: 20)
    }
    
    // MARK: - TEXTURE PREVIEW
    
    private var texturePreview: some View {
        LazyImage(asset.thumbnail)
            .scaledToFill()
    }
    
    // MARK: - MATERIAL PICKER
    
    private var materialPicer: some View {
        HStack {
            ForEach(MaterialType.allCases, id: \.self) { material in
                Circle()
                    .frame(width: 30)
                    .foregroundStyle(material.material)
                    .overlay {
                        if selectedMaterial == material {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.white.opacity(0.7))
                        }
                    }
                    .onTapGesture {
                        withAnimation(UIConstants.animationType) {
                            selectedMaterial = material
                        }
                    }
                    .hoverEffect()
            }
        }
    }
    
    // MARK: - ASSET PRICE INFORMATION
    
    private var assetPriceInformation: some View {
        VStack(alignment: .leading, spacing: UIConstants.compactVStackSpacing) {
            Text(asset.title)
                .font(.title2)
            
            HStack {
                if let discount = asset.discount {
                    Price("\(GeneralUtilities.calculateDiscountedPrice(originalPrice: asset.price, discountPercentage: discount) ?? "0")")
                        .font(.title2)
                }
                
                Price(asset.price)
                    .font(.title3)
                    .strikethrough()
                    .foregroundStyle(.secondary)
                
                if let discount = asset.discount {
                    Text("\(discount)% Off")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
            }
            
            HStack {
                Button {
                    
                } label: {
                    Label("Add To Cart", systemImage: "cart")
                        .frame(maxWidth: .infinity)
                }
                
                Button("Trade", systemImage: "arrow.left.arrow.right") {}
            }
        }
        .align(.leading)
    }
    
    // MARK: - ASSET DESCRIPTION
    
    private var assetDescription: some View {
        SectionStack("Description") {
            Text(asset.description)
                .lineLimit(expandDescriptionLineLimit ? nil : 2)
            
            Text(expandDescriptionLineLimit ? "Read Less" : "Read More")
                .heading()
                .onTapGesture {
                    withAnimation(UIConstants.animationType) {
                        expandDescriptionLineLimit.toggle()
                    }
                }
                .hoverEffect(.lift)
        }
        .align(.leading)
    }
    
    // MARK: - ASSET TAGS
    
    private var assetTags: some View {
        FlowLayout(asset.tags, \.self) { row in
            Text("#\(row)")
                .fontWeight(.bold)
                .padding(.horizontal, 6)
                .materialBackdrop(cornerRadius: 50, padding: 10)
        }
        .padding(.horizontal, -4)
    }
    
    // MARK: - ASSET DETIALS
    
    private var assetDetials: some View {
        Group {
            if let assetType = AssetType(rawValue: asset.type) {
                switch assetType {
                case .models, .textures, .shaders, .plugins, .hdris:
                    modelDetails
                case .scripts:
                    scriptDetails
                case .printable:
                    printableDetails
                }
            } else {
                ContentUnavailableView("Data Unavailable", systemImage: "exclamationmark.triangle.fill")
            }
        }
    }
    
    // MARK: - 3D MODEL DETAILS
    
    private var modelDetails: some View {
        SectionStack("Model Details") {
            Divider()
            
            cell("Resolution", description: asset.resolution ?? "1920x1080")
            Divider()
            
            cell("LODs", description: asset.lods ?? "1000")
            Divider()
            
            cell("Physical", description: asset.physicalSize ?? "1.5")
            Divider()
            
            cell("Vertices", description: asset.vertices ?? "2")
            Divider()
            
            cell("Textures", description: asset.textures?.booleanDescriptor ?? "No")
            Divider()
            
            cell("Materials", description: asset.materials?.booleanDescriptor ?? "No")
            Divider()
            
            cell("Rigged", description: asset.rigged?.booleanDescriptor ?? "No")
            Divider()
            
            cell("Animated", description: asset.animated?.booleanDescriptor ?? "No")
            Divider()
            
            cell("VR / AR / Low-poly", description: asset.vrArLowPoly?.booleanDescriptor ?? "No")
            Divider()
        }
    }
    
    // MARK: - SCRIPT DETAILS
    
    private var scriptDetails: some View {
        SectionStack("Script Details") {
            Divider()
            
            cell("Language", description: asset.script ?? "Python")
            Divider()
            
            cell("LODs", description: asset.scriptName ?? "main.py")
            Divider()
            
            cell("Physical", description: "\(asset.scriptSize ?? 0)")
            Divider()
        }
    }
    
    // MARK: - PRINTABLE DETAILS
    
    private var printableDetails: some View {
        SectionStack("Printable Details") {
            Divider()
            
            cell("Vertices", description : asset.vertices ?? "4")
            Divider()
            
            cell("Volume", description : asset.volume ?? "23")
            Divider()
            
            cell("Physical Size", description : asset.physicalSize ?? "")
            Divider()
            
            cell("Resolution", description : asset.resolution ?? "")
            Divider()
            
            cell("Surface Area", description : asset.surfaceArea ?? "")
            Divider()
            
            cell("Layer Height", description : asset.layerHeight ?? "")
            Divider()
            
            cell("Infill Percentage", description : asset.infillPercentage ?? "")
            Divider()
            
            cell("Print Time Estimate", description : asset.printTimeEstimate ?? "")
            Divider()
            
            cell("Material", description : asset.material ?? "")
            Divider()
            
            cell("Nozzle Size", description : asset.nozzleSize ?? "")
            Divider()
            
            cell("Watertight", description : asset.watertight?.booleanDescriptor ?? "")
            Divider()
            
            cell("Manifold", description : asset.manifold?.booleanDescriptor ?? "")
            Divider()
        }
    }
    
    // MARK: - ROW CELL
    
    private func cell(_ titleKey: String, description: String) -> some View {
        HStack {
            Text(titleKey)
                .fontWeight(.semibold)
            
            Spacer()
            
            Text(description)
        }
    }
}

#Preview(windowStyle: .automatic) {
    NavigationSplitView {
        Text("")
    } detail: {
        AssetDetailsView(DummyData.asset)
    }
}

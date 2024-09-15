//
//  Model3DViewer.swift
//  Meshables
//
//  Created by Aum Chauhan on 09/09/24.
//

import SwiftUI
import RealityKit

/// A view that loads and displays a 3D model from a USDZ file.
struct Model3DViewer: View {
    
    // MARK: - PROPERTIES
    
    let urlKey: String
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = Model3DViewModel()
    
    @State var angle: Angle = .degrees(0)
    @State var startAngle: Angle?
    @State var axis: (CGFloat, CGFloat, CGFloat) = (.zero, .zero, .zero)
    @State var startAxis: (CGFloat, CGFloat, CGFloat)?
    @State var scale: Double = 1.0
    @State var startScale: Double?
    
    // MARK: - INITIALIZER
    
    init(_ urlKey: String) {
        self.urlKey = urlKey
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        RealityView { view in
            
        } update: { content in
            if viewModel.entity == nil && !content.entities.isEmpty {
                content.entities.removeAll()
            }
            
            if let entity = viewModel.entity {
                content.entities.removeAll()
                content.add(entity)
            }
        }
        .rotation3DEffect(angle, axis: axis)
        .scaleEffect(scale)
        .simultaneousGesture(
            DragGesture()
                .onChanged { value in
                    if let startAngle, let startAxis {
                        let _angle = sqrt(pow(value.translation.width, 2) + pow(value.translation.height, 2)) + startAngle.degrees
                        let _ = ((-value.translation.height + startAxis.0) / CGFloat(_angle))
                        let axisY = ((value.translation.width + startAxis.1) / CGFloat(_angle))
                        
                        angle = Angle(degrees: Double(_angle))
                        axis = (0, axisY, 0)
                    } else {
                        startAngle = angle
                        startAxis = axis
                    }
                }
                .onEnded { _ in
                    startAngle = angle
                    startAxis = axis
                }
        )
        .simultaneousGesture(
            MagnifyGesture()
                .onChanged { value in
                    if let startScale {
                        scale = max(1, min(3, value.magnification * startScale))
                    } else {
                        startScale = scale
                    }
                }
                .onEnded { _ in
                    startScale = scale
                }
        )
        .align(.bottom)
        .task {
            await viewModel.fetchUSDZFileURL(from: urlKey)
            viewModel.onItemDeleted = {
                dismiss()
            }
        }
    }
}

#Preview {
    Model3DViewer("https://developer.apple.com/augmented-reality/quick-look/models/retrotv/tv_retro.usdz")
}

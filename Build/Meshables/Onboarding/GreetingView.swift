//
//  GreetingView.swift
//  Meshables
//
//  Created by Aum Chauhan on 19/08/24.
//

import SwiftUI

/// Displays a greeting screen with a logo, welcome message, app description, and a list of feature cells.
struct GreetingView: View {
    
    // MARK: - PROPERTIES
    
    @Binding var showGreetingSheet: Bool
    
    // MARK: - VIEW BODY
    
    var body: some View {
        VStack(alignment: .leading, spacing: UIConstants.standardVStackSpacing) {
            MeshablesLogo()
            
            greeting
            
            features
            
            StretchedButton(titleKey: "Continue") {
                withAnimation(UIConstants.animationType) {
                    showGreetingSheet.toggle()
                }
            }
            .align(.bottom)
        }
    }
    
    // MARK: - GREETING
    
    private var greeting: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Welcome to Meshables")
                .font(.largeTitle)
            
            Text("Your ultimate marketplace for premium 3D assets and game development resources.")
                .secondaryTitle()
        }
    }
    
    // MARK: - FEATURES
    
    private var features: some View {
        Group {
            featureCell(
                systemImage: "arrow.left.arrow.right",
                titleKey: "Asset Trading",
                description: "Exchange resources easily and expand your creative toolbox."
            )
            
            featureCell(
                systemImage: "move.3d",
                titleKey: "Wide Range of Assets",
                description: "Discover a diverse collection of high-quality assets tailored for various genres and styles."
            )
            
            featureCell(
                systemImage: "doc.fill",
                titleKey: "Popular 3D File Formats",
                description: "Supports GLB and GLTF formats for compatibility and ease of integration."
            )
        }
    }
}

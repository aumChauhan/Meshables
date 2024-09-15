//
//  OnboardLayout.swift
//  Meshables
//
//  Created by Aum Chauhan on 03/09/24.
//

import SwiftUI
import SplineRuntime

/// A view layout for onboarding screens, featuring a cover image on the left and a custom view on the right.
struct OnboardLayout<Content>: View where Content: View {
    
    // MARK: - PROPERTIES
    
    let content: Content
    let url = URL(string: "https://build.spline.design/vX1itdSdgGJKeD37i0ax/scene.splineswift")!
    @EnvironmentObject private var authenticationViewModel: AuthenticationViewModel
    
    // MARK: - INITIALIZER
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                interactiveModel(geometry)

                customContent(geometry)
            }
            .background {
                LinearGradient(colors: [.black.opacity(0.15), .clear], startPoint: .top, endPoint: .bottom)
            }
        }
    }
    
    // MARK: - INTERACTIVE SPLINE MODEL
    
    private func interactiveModel(_ geometry: GeometryProxy) -> some View {
        SplineView(sceneFileURL: url) { viewPhase in
            LinearGradient(colors: [.almostBlack, .almostGray], startPoint: .top, endPoint: .bottom)
            viewPhase.content
        }
        .frame(width: geometry.size.width * 0.55)
        .borderRadius(45)
        .animation(UIConstants.animationType, value: url)
    }
    
    // MARK: - CUSTOM CONTENT
    
    private func customContent(_ geometry: GeometryProxy) -> some View {
        content
            .if(authenticationViewModel.isLoading) { _ in
                ProgressBar(titleKey: "Please Wait")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(UIConstants.standardContentPadding)
            }
            .padding(UIConstants.standardMargin)
            .frame(width: geometry.size.width * 0.45)
    }
    
}

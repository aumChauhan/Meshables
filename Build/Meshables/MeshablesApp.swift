//
//  MeshablesApp.swift
//  Meshables
//
//  Created by Aum Chauhan on 18/08/24.
//

import SwiftUI
import SwiftData
import FirebaseCore

@main
struct MeshablesApp: App {
    
    // MARK: - PROPERTIES
    
    @StateObject private var authenticationViewModel = AuthenticationViewModel()

    // MARK: - INITIALIZER
    
    init() {
        FirebaseApp.configure()
    }
    
    // MARK: - SCENE
    
    var body: some Scene {
        WindowGroup {
            AppNavigator()
        }
        .environmentObject(authenticationViewModel)
        .modelContainer(for: [CartItem.self])
        
        WindowGroup(id: "asset", for: String.self) { url in
            Model3DViewer(url.wrappedValue!)
                .scaleEffect(0.4)
        }
        .windowStyle(.volumetric)
    }
}

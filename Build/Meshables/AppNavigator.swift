//
//  AppNavigator.swift
//  Meshables
//
//  Created by Aum Chauhan on 18/08/24.
//

import SwiftUI

/// Root navigation container with tab-based interface for different sections.
struct AppNavigator: View {
    
    // MARK: - PROPERTIES
    
    @State private var showGreetingSheet: Bool = true
    @State private var showAccountAccessSheet: Bool = false
    @EnvironmentObject private var authenticationViewModel: AuthenticationViewModel
    
    // MARK: - VIEW BODY
    
    var body: some View {
        OnboardLayout {
            AccountAccessView()
                .if(showGreetingSheet) { _ in
                    GreetingView(showGreetingSheet: $showGreetingSheet)
                }
        }
        .if(authenticationViewModel.isSessionActive()) { _ in
            TabView {
                AssetCatalogView()
                    .tabBarItem(systemImage: "house.fill", "Asset Catalog")
                
                ExploreView()
                    .tabBarItem(systemImage: "safari.fill", "Explore")
                
                UserProfileView()
                    .tabBarItem(systemImage: "person.fill", "Profile")
                
                SettingsView()
                    .tabBarItem(systemImage: "gear", "Settings")
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    AppNavigator()
        .environmentObject(AuthenticationViewModel())
}

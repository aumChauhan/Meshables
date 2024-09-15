//
//  SettingsView.swift
//  Meshables
//
//  Created by Aum Chauhan on 21/08/24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationSplitView {
            List {
                UserProfileCard(user: DummyData.userProfile)
                
                Section("Profile") {
                    NavigationLink {
                        
                    } label: {
                        LabelCard("User Information", systemImage: "person.fill")
                    }
                }

                Section("App Settings") {
                    NavigationLink {
                        
                    } label: {
                        LabelCard("General", systemImage: "gear")
                    }
                    
                    NavigationLink {
                        
                    } label: {
                        LabelCard("Appearance", systemImage: "paintbrush.fill")
                    }
                }
                
                Section("Session") {
                    Button {
                        authenticationViewModel.signOut()
                    } label: {
                        LabelCard("Sign Out", systemImage: "figure.walk")
                    }
                }
            }
            .listStyle(.sidebar)
            .listSectionSpacing(.compact)
            
            .navigationTitle("Settings")
        } detail: {
            
        }
    }
}

#Preview {
    SettingsView()
}

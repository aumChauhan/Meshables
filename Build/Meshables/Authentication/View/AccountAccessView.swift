//
//  AccountAccessView.swift
//  Meshables
//
//  Created by Aum Chauhan on 19/08/24.
//

import SwiftUI
import SplineRuntime

/// Provides a view for account access, authentication options, and terms of service.
struct AccountAccessView: View {
    
    // MARK: - PROPERTIES
    
    @State private var isResetPasswordSheetPresent: Bool = false
    @EnvironmentObject private var authenticationViewModel: AuthenticationViewModel
    
    // MARK: - VIEW BODY
    
    var body: some View {
        VStack(alignment: .center, spacing: UIConstants.standardVStackSpacing) {
            authenticationMethods
            
            VStack(spacing: UIConstants.compactVStackSpacing) {
                signInForm
                    .if(authenticationViewModel.isSigningUp()) { _ in
                        signUpForm
                    }
                
                Spacer()
                
                footer
            }
        }
        .animation(UIConstants.animationType, value: authenticationViewModel.authenticationAction)
        .transition(.move(edge: .trailing))
        .onChange(of: authenticationViewModel.authenticationAction) {
            authenticationViewModel.resetTextfields()
        }
        
        .alert("Account Access Failed",
               isPresented: $authenticationViewModel.alertPresenter,
               message: authenticationViewModel.alertDescription
        )
        .sheet(isPresented: $isResetPasswordSheetPresent) {
            ResetPasswordView()
                .frame(width: 500, height: 500)
        }
    }
    
    // MARK: - AUTHENTICATION METHODS
    
    private var authenticationMethods: some View {
        Group {
            Text(authenticationViewModel.isSigningUp() ? "Get Started by\nCreating an Account": "Welcome Back!\nSign In to Continue")
                .font(.largeTitle)
                .align(.leading)
            
            Picker("", selection: $authenticationViewModel.authenticationAction) {
                ForEach(AuthenticationAction.allCases, id: \.self) { authMethod in
                    Text(authMethod.rawValue)
                        .tag(authMethod)
                }
            }
            .pickerStyle(.palette)
        }
    }
    
    // MARK: - SIGN IN FORM
    
    private var signInForm: some View {
        Group {
            TextBox(placeholder: "Email Address", systemImage: "at", text: $authenticationViewModel.emailAddress)
            
            TextBox(placeholder: "Password", isSecure: true, systemImage: "key.fill", text: $authenticationViewModel.password)
            
            Divider()
            
            VStack(alignment: .leading, spacing: UIConstants.compactVStackSpacing) {
                StretchedButton(titleKey: "Sign In") {
                    authenticationViewModel.signIn()
                }
                
                resetPassword
            }
        }
    }
    
    // MARK: - SIGN UP FORM
    
    private var signUpForm: some View {
        Group {
            TextBox(placeholder: "Name", systemImage: "person.fill", text: $authenticationViewModel.userName)
            
            TextBox(placeholder: "Email Address", systemImage: "at", text: $authenticationViewModel.emailAddress)
            
            TextBox(placeholder: "Password", isSecure: true, systemImage: "key.fill", text: $authenticationViewModel.password)
            
            Divider()
            
            StretchedButton(titleKey: "Sign Up") {
                authenticationViewModel.createUserProfile()
            }
        }
    }
    
    // MARK: - RESET PASSWORD
    
    private var resetPassword: some View {
        Text("Reset Password?")
            .onTapGesture {
                isResetPasswordSheetPresent.toggle()
            }
            .hoverEffect(.highlight, isEnabled: true)
            .padding(.leading, 10)
    }
    
    // MARK: - FOOTER
    
    private var footer: some View {
        Group {
            Text("By registration you agree to Terms of Use and Privacy Policy.")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            Text("© 2024 Meshables")
                .foregroundStyle(.primary)
        }
    }
}

#Preview(windowStyle: .automatic) {
    AccountAccessView()
        .environmentObject(AuthenticationViewModel())
}

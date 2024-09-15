//
//  ResetPasswordView.swift
//  Meshables
//
//  Created by Aum Chauhan on 03/09/24.
//

import SwiftUI

/// A view that provides a user interface for resetting the user's password.
struct ResetPasswordView: View {
    
    // MARK: - PROPERTIES
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var authenticationViewModel: AuthenticationViewModel
    
    // MARK: - VIEW BODY
    
    var body: some View {
        NavigationStack {
            resetPasswordForm
            
                .navigationTitle("Reset Password")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Cancel", systemImage: "xmark") {
                            dismiss()
                        }
                    }
                }
        }
        .animation(UIConstants.animationType, value: authenticationViewModel.authenticationAction)
        
        .alert("Account Access Failed",
               isPresented: $authenticationViewModel.alertPresenter,
               message: authenticationViewModel.alertDescription
        )
    }
    
    // MARK: - FORM
    
    private var resetPasswordForm: some View {
        VStack(alignment: .leading, spacing: UIConstants.compactVStackSpacing) {
            TextBox(placeholder: "Email Address", systemImage: "at", text: $authenticationViewModel.emailAddress)
            
            Text("Enter your registered email address to initiate the password reset process. We’ll send you a link to create a new password.")
                .subheading()
                .padding(.horizontal, 4)
            
            Spacer()
            
            StretchedButton(titleKey: "Send Email") {
                authenticationViewModel.resetPassword()
                authenticationViewModel.resetTextfields()
            }
        }
        .padding([.horizontal, .bottom], UIConstants.standardMargin)
    }
}

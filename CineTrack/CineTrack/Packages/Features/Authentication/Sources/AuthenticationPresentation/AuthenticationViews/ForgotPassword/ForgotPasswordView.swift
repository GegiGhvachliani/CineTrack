//
//  ForgotPasswordView.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 05/07/2026.
//

import SwiftUI
import DesignSystemTokens

public struct ForgotPasswordView<ViewModel: SignInViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack {
            ColorTokens.Background.primary
                .ignoresSafeArea()
            
            VStack(spacing: 5) {
                
                VStack(spacing: 8) {
                    Text(AuthenticationStrings.ForgotPassword.title)
                        .font(TypographyTokens.title2)
                    
                    Text(AuthenticationStrings.ForgotPassword.subtitle)
                        .font(TypographyTokens.body)
                        .foregroundStyle(ColorTokens.Text.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 30)
                .padding(.bottom, 20)
                
                EmailFieldView(
                    email: $viewModel.forgotPasswordEmail,
                    text: AuthenticationStrings.SignIn.emailPlaceholder
                )
                .padding(.bottom, 20)
                
                ButtonView(
                    title: AuthenticationStrings.ForgotPassword.sendButton,
                    isLoading: viewModel.isLoading
                ) {
                    Task {
                        await viewModel.sendResetPasswordLink()
                        if viewModel.forgotPasswordErrorMessage == nil {
                            dismiss()
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .errorModal(message: $viewModel.forgotPasswordErrorMessage)
    }
}

#Preview {
    ForgotPasswordView(viewModel: MockSignInViewModel())
}

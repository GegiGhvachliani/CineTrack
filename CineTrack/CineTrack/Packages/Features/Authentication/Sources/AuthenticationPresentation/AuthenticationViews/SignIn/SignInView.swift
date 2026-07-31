//
//  SignInView.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 05/07/2026.
//

import SwiftUI
import DesignSystemTokens

public struct SignInView<ViewModel: SignInViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack {
            ColorTokens.Background.primary
                .ignoresSafeArea()
            VStack(spacing: 10) {
                Spacer()

                headerSection

                middleSection

                belowSection

                Spacer()
            }
            .padding()
        }
        .errorModal(message: $viewModel.errorMessage)
    }

    private var headerSection: some View {
        VStack(spacing: 10) {
            Text(AuthenticationStrings.SignIn.title)
                .font(TypographyTokens.largeTitle)
            Text(AuthenticationStrings.SignIn.subtitle)
                .font(TypographyTokens.body)
                .foregroundStyle(ColorTokens.Text.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.bottom, 40)
    }

    private var middleSection: some View {
        VStack {
            EmailFieldView(email: $viewModel.email, text: AuthenticationStrings.SignIn.emailPlaceholder)
                .padding(.bottom, 30)

            PasswordFieldView(
                password: $viewModel.password,
                title: AuthenticationStrings.SignIn.passwordPlaceholder
            )

            HStack {
                Spacer()

                Text(AuthenticationStrings.SignIn.dontHaveAccount)
                    .font(TypographyTokens.bodySmall)
                Button {
                    viewModel.navigateToSignUp()
                } label: {
                    Text(AuthenticationStrings.SignIn.signUpLink)
                        .font(TypographyTokens.bodySmall)
                        .foregroundStyle(ColorTokens.Brand.primary)
                        .offset(x: -7)
                }
            }
        }
        .padding(.bottom, 40)
    }

    private var belowSection: some View {
        VStack {
            ButtonView(
                title: AuthenticationStrings.SignIn.signInButton,
                isLoading: viewModel.isLoading
            ) {
                Task {
                    await viewModel.signInWithEmail()
                }
            }

            HStack(spacing: 15) {
                Rectangle()
                    .fill(DesignSystemTokens.ColorTokens.Brand.primary.opacity(0.5))
                    .frame(width: 150, height: 1)
                Text("OR")
                    .font(DesignSystemTokens.TypographyTokens.footnote)
                Rectangle()
                    .fill(DesignSystemTokens.ColorTokens.Brand.primary.opacity(0.8))
                    .frame(width: 150, height: 1)
            }

            Button {
                Task {
                    await viewModel.signInWithGoogle()
                }
            } label: {
                HStack {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(
                                CircularProgressViewStyle(tint: DesignSystemTokens.ColorTokens.Text.inverse)
                            )
                    } else {
                        Text(AuthenticationStrings.SignIn.googleButton)
                            .font(TypographyTokens.body)
                            .foregroundStyle(DesignSystemTokens.ColorTokens.Text.inverse)
                        Image(AuthenticationStrings.SignIn.googleButtonIcon, bundle: .module)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.leading, 5)
                    }
                }
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(DesignSystemTokens.ColorTokens.Brand.primary)
                .cornerRadius(15)
            }
            .disabled(viewModel.isLoading)
        }
    }
}

final class MockSignInViewModel: SignInViewModelProtocol {
   @Published var email = ""
   @Published var password = ""
   @Published var isLoading = false
   @Published var errorMessage: String?

   @Published var forgotPasswordEmail = ""
   @Published var isForgotPasswordPresented = false
   @Published var forgotPasswordSuccessMessage: String?
   @Published var forgotPasswordErrorMessage: String?

   func signInWithEmail() async { print("Mock Sign In") }
   func signInWithGoogle() async { print("Mock Google Sign In") }
   func sendResetPasswordLink() async { print("Mock Reset") }
   func navigateToSignUp() { print("Navigate to Sign Up") }
}

#Preview {
   SignInView(viewModel: MockSignInViewModel())
}

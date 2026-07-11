//
//  SignUpView.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import SwiftUI
import DesignSystemTokens

public struct SignUpView<ViewModel: SignUpViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    private let onSignInTap: () -> Void

    public init(
        viewModel: ViewModel,
        onSignInTap: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.onSignInTap = onSignInTap
    }

    public var body: some View {
        ZStack {
            ColorTokens.Background.primary
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 10) {
                    Spacer()

                    headerSection

                    middleSection

                    belowSection

                    Spacer()
                }
                .padding()
            }
        }
        .errorModal(message: $viewModel.errorMessage)
    }

    private var headerSection: some View {
        VStack(spacing: 10) {
            Text(AuthenticationStrings.SignUp.title)
                .font(TypographyTokens.largeTitle)
            Text(AuthenticationStrings.SignUp.subtitle)
                .font(TypographyTokens.body)
                .foregroundStyle(ColorTokens.Text.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 20)
        .padding(.bottom, 40)
    }

    private var middleSection: some View {
        VStack {
            TextFieldView(
                title: AuthenticationStrings.SignUp.usernamePlaceholder,
                icon: "person.fill",
                text: $viewModel.username
            )
            .padding(.bottom, 20)

            EmailFieldView(
                email: $viewModel.email,
                text: AuthenticationStrings.SignUp.emailPlaceholder
            )
            .padding(.bottom, 20)

            PasswordFieldView(
                password: $viewModel.password,
                title: AuthenticationStrings.SignUp.passwordPlaceholder
            )
            .padding(.bottom, 20)

            PasswordFieldView(
                password: $viewModel.confirmPassword,
                title: AuthenticationStrings.SignUp.confirmPasswordPlaceholder
            )

            HStack {
                Spacer()

                Text(AuthenticationStrings.SignUp.alreadyHaveAccount)
                    .font(TypographyTokens.bodySmall)
                Button {
                    onSignInTap()
                } label: {
                    Text(AuthenticationStrings.SignUp.signInLink)
                        .font(TypographyTokens.bodySmall)
                        .foregroundStyle(ColorTokens.Brand.primary)
                        .offset(x: -7)
                }
                .frame(alignment: .trailing)
            }
        }
        .padding(.bottom, 40)
    }

    private var belowSection: some View {
        ButtonView(
            title: AuthenticationStrings.SignUp.signUpButton,
            isLoading: viewModel.isLoading
        ) {
            Task {
                await viewModel.signUpWithEmail()
            }
        }
    }
}

final class MockSignUpViewModel: SignUpViewModelProtocol {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    func signUpWithEmail() async { print("Mock Sign Up") }
}

#Preview {
    SignUpView(
        viewModel: MockSignUpViewModel(),
        onSignInTap: { print("SignInTapped") }
    )
}

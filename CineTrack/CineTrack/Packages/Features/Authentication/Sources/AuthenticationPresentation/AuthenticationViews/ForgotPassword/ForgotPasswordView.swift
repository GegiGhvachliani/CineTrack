//
//  ForgotPasswordView.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 05/07/2026.
//

import SwiftUI
import Observation
import DesignSystemTokens

public struct ForgotPasswordView<ViewModel: SignInViewModelProtocol>: View {

    // MARK: - Properties

    @Bindable
    var viewModel: ViewModel
    @Environment(\.dismiss)
    var dismiss

    // MARK: - Initialization

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    public var body: some View {
        ZStack {
            ColorTokens.Background.primary
                .ignoresSafeArea()

            GeometryReader { geometry in
                VStack(spacing: 5) {
                    Spacer()

                    VStack(spacing: 8) {
                        Text(AuthenticationStrings.ForgotPassword.title)
                            .font(TypographyTokens.title2)

                        Text(AuthenticationStrings.ForgotPassword.subtitle)
                            .font(TypographyTokens.body)
                            .foregroundStyle(ColorTokens.Text.secondary)
                            .multilineTextAlignment(.center)
                    }
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
                            if await viewModel.sendResetPasswordLink() {
                                dismiss()
                            }
                        }
                    }

                    Spacer()
                }
                .frame(minHeight: geometry.size.height)
                .padding()
            }
        }
        .errorModal(message: $viewModel.forgotPasswordErrorMessage)
    }
}

#Preview {
    ForgotPasswordView(viewModel: MockSignInViewModel())
}

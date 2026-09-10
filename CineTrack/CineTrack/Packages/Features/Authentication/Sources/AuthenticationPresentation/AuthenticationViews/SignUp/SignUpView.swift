//
//  SignUpView.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import SwiftUI
import DesignSystemTokens

public struct SignUpView<ViewModel: SignUpViewModelProtocol>: View {

    // MARK: - Properties

    @State
    private var viewModel: ViewModel

    // MARK: - Initialization

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    public var body: some View {
        @Bindable
        var viewModel = viewModel

        ZStack {
            ColorTokens.Background.primary
                .ignoresSafeArea()

            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 10) {
                        Spacer()
                        headerSection
                        middleSection
                        belowSection
                        Spacer()
                    }
                    .frame(minHeight: geometry.size.height)
                    .padding()
                }
                .scrollDismissesKeyboard(.interactively)
            }
        }
        .navigationBarBackButtonHidden()
        .errorModal(message: $viewModel.errorMessage)
    }

    private var headerSection: some View {
        SignUpHeaderSectionView()
    }

    private var middleSection: some View {
        @Bindable
        var viewModel = viewModel

        return SignUpFormSectionView(
            username: $viewModel.username,
            email: $viewModel.email,
            password: $viewModel.password,
            confirmPassword: $viewModel.confirmPassword,
            onSignIn: viewModel.navigateToSignIn
        )
    }

    private var belowSection: some View {
        SignUpActionsSectionView(
            isLoading: viewModel.isLoading,
            onSignUp: { Task { await viewModel.signUpWithEmail() } }
        )
    }
}

#Preview {
    SignUpView(viewModel: MockSignUpViewModel())
}

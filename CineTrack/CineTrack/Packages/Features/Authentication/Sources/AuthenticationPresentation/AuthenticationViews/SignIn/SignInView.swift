//
//  SignInView.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 05/07/2026.
//

import SwiftUI
import Observation
import DesignSystemTokens

public struct SignInView<ViewModel: SignInViewModelProtocol>: View {

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
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .errorModal(message: $viewModel.errorMessage)
        .sheet(isPresented: $viewModel.isForgotPasswordPresented) {
            ForgotPasswordView(viewModel: viewModel)
                .presentationDetents([.height(350)])
                .presentationDragIndicator(.visible)
        }
    }

    private var headerSection: some View {
        SignInHeaderSectionView()
    }

    private var middleSection: some View {
        @Bindable
        var viewModel = viewModel

        return SignInFormSectionView(
            email: $viewModel.email,
            password: $viewModel.password,
            onForgotPassword: { viewModel.isForgotPasswordPresented = true }
        )
    }

    private var belowSection: some View {
        SignInActionsSectionView(
            isLoading: viewModel.isLoading,
            isEmailLoading: viewModel.isEmailLoading,
            isGoogleLoading: viewModel.isGoogleLoading,
            onEmailSignIn: { Task { await viewModel.signInWithEmail() } },
            onGoogleSignIn: { Task { await viewModel.signInWithGoogle() } },
            onSignUp: viewModel.navigateToSignUp
        )
    }
}

#Preview {
    SignInView(viewModel: MockSignInViewModel())
}

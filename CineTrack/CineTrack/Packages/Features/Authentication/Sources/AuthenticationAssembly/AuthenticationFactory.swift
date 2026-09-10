//
//  AuthenticationFactory.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import UIKit
import SwiftUI
import AuthenticationDomain
import AuthenticationData
import AuthenticationPresentationAPI
import AuthenticationPresentation

public final class AuthenticationFactory: AuthenticationFactoryProtocol {

    // MARK: - Properties

    private let repository: AuthenticationRepositoryProtocol

    // MARK: - Initialization

    public init(service: AuthenticationServiceProtocol = FirebaseAuthenticationService()) {
        self.repository = AuthenticationRepository(service: service)
    }

    public func isUserAuthenticated() -> Bool {
        let useCase: CheckAuthenticationStatusUseCaseProtocol = CheckAuthenticationStatusUseCase(repository: repository)
        return useCase.execute()
    }

    public func makeAuthenticationCoordinator(navigationController: UINavigationController)
        -> AuthenticationCoordinatorProtocol {
        return AuthenticationCoordinator(
            navigationController: navigationController,
            factory: self
        )
    }

    public func makeSignInViewController(coordinator: AuthenticationNavigationProtocol) -> UIViewController {
        let signInWithEmailUseCase = SignInWithEmailUseCase(repository: repository)
        let signInWithGoogleUseCase = SignInWithGoogleUseCase(repository: repository)
        let resetPasswordUseCase = ResetPasswordUseCase(repository: repository)

        let viewModel = SignInViewModel(
            signInWithEmailUseCase: signInWithEmailUseCase,
            signInWithGoogleUseCase: signInWithGoogleUseCase,
            resetPasswordUseCase: resetPasswordUseCase
        )

        viewModel.onSignUp = { [weak coordinator] in coordinator?.showSignUp() }
        viewModel.onAuthenticated = { [weak coordinator] in coordinator?.onFinish?() }

        let signInView = SignInView(viewModel: viewModel)
        return UIHostingController(rootView: signInView)
    }

    public func makeSignUpViewController(coordinator: AuthenticationNavigationProtocol) -> UIViewController {
        let validateSignUpUseCase: ValidateSignUpUseCaseProtocol = ValidateSignUpUseCase(
            validator: AuthenticationValidator())
        let signUpWithEmailUseCase = SignUpWithEmailUseCase(repository: repository)

        let viewModel = SignUpViewModel(
            signUpWithEmailUseCase: signUpWithEmailUseCase,
            validateSignUpUseCase: validateSignUpUseCase
        )

        viewModel.onSignIn = { [weak coordinator] in coordinator?.navigateBack() }
        viewModel.onAuthenticated = { [weak coordinator] in coordinator?.onFinish?() }

        let signUpView = SignUpView(viewModel: viewModel)
        return UIHostingController(rootView: signUpView)
    }
}

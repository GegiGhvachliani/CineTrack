//
//  AuthenticationCoordinator.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import UIKit
import SwiftUI
import SharedCore
import AuthenticationDomain
import AuthenticationPresentationAPI

public final class AuthenticationCoordinator: AuthenticationCoordinatorProtocol {
    
    // MARK: - Protocol Properties
    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    public var onFinish: (() -> Void)?
    
    // MARK: - Dependencies
    private let signInWithEmailUseCase: SignInWithEmailUseCaseProtocol
    private let signInWithGoogleUseCase: SignInWithGoogleUseCaseProtocol
    private let signUpWithEmailUseCase: SignUpWithEmailUseCaseProtocol
    private let resetPasswordUseCase: ResetPasswordUseCaseProtocol
    private let validator: AuthenticationValidating

    
    // MARK: - Initialization
    public init(
        navigationController: UINavigationController,
        signInWithEmailUseCase: SignInWithEmailUseCaseProtocol,
        signInWithGoogleUseCase: SignInWithGoogleUseCaseProtocol,
        signUpWithEmailUseCase: SignUpWithEmailUseCaseProtocol,
        resetPasswordUseCase: ResetPasswordUseCaseProtocol,
        validator: AuthenticationValidating
    ) {
        self.navigationController = navigationController
        self.signInWithEmailUseCase = signInWithEmailUseCase
        self.signInWithGoogleUseCase = signInWithGoogleUseCase
        self.signUpWithEmailUseCase = signUpWithEmailUseCase
        self.resetPasswordUseCase = resetPasswordUseCase
        self.validator = validator
    }
    
    //MARK: - Methods
    public func start() {
        showSignIn()
    }
    
    private func showSignIn() {
            let viewModel = SignInViewModel(
                signInWithEmailUseCase: signInWithEmailUseCase,
                signInWithGoogleUseCase: signInWithGoogleUseCase,
                resetPasswordUseCase: resetPasswordUseCase,
                coordinator: self
            )
            
        let signInView = SignInView(viewModel: viewModel, onSignUpTapped: { [weak self] in
                self?.showSignUp()
            })
            
            let hostingController = UIHostingController(rootView: signInView)
            if navigationController.viewControllers.isEmpty {
                navigationController.setViewControllers([hostingController], animated: true)
            } else {
                navigationController.pushViewController(hostingController, animated: true)
            }
        }
        
        private func showSignUp() {
            let viewModel = SignUpViewModel(
                signUpWithEmailUseCase: signUpWithEmailUseCase,
                validator: validator,
                coordinator: self
            )
            
            let signUpView = SignUpView(viewModel: viewModel, onSignInTap: { [weak self] in
                self?.navigationController.popViewController(animated: true)
            })
            
            let hostingController = UIHostingController(rootView: signUpView)
            navigationController.pushViewController(hostingController, animated: true)
        }
}

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

public final class AuthenticationFactory: AuthenticationFactoryProtocol, AuthenticationPresentationFactoryProtocol {
    
    private let repository = AuthenticationRepository()
    
    public init() {}
    
    public func isUserAuthenticated() -> Bool {
        return repository.isUserAuthenticated()
    }
    
    public func makeAuthenticationCoordinator(navigationController: UINavigationController) -> AuthenticationCoordinatorProtocol {
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
            resetPasswordUseCase: resetPasswordUseCase,
            coordinator: coordinator
        )
        
        let signInView = SignInView(viewModel: viewModel)
        return UIHostingController(rootView: signInView)
    }
    
    public func makeSignUpViewController(coordinator: AuthenticationNavigationProtocol) -> UIViewController {
        let validator = AuthenticationValidator()
        let signUpWithEmailUseCase = SignUpWithEmailUseCase(repository: repository)
        
        let viewModel = SignUpViewModel(
            signUpWithEmailUseCase: signUpWithEmailUseCase,
            validator: validator,
            coordinator: coordinator
        )
        
        let signUpView = SignUpView(viewModel: viewModel)
        return UIHostingController(rootView: signUpView)
    }
}

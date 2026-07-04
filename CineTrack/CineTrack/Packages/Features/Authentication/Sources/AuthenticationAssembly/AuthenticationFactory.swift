//
//  AuthenticationFactory.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import UIKit
import AuthenticationDomain
import AuthenticationData
import AuthenticationPresentationAPI
import AuthenticationPresentation

public final class AuthenticationFactory: AuthenticationFactoryProtocol {
    
    // MARK: - Initialization
    public init() {}
    
    // MARK: - Methods
    public func isUserAuthenticated() -> Bool {
        let repository = AuthenticationRepository()
        return repository.isUserAuthenticated()
    }
    
    public func makeAuthenticationCoordinator(navigationController: UINavigationController) -> AuthenticationCoordinatorProtocol {
        
        let repository = AuthenticationRepository()
        let validator = AuthenticationValidator()
        
        let signInWithEmailUseCase = SignInWithEmailUseCase(repository: repository)
        let signInWithGoogleUseCase = SignInWithGoogleUseCase(repository: repository)
        let signUpWithEmailUseCase = SignUpWithEmailUseCase(repository: repository)
        let resetPasswordUseCase = ResetPasswordUseCase(repository: repository)
        
        return AuthenticationCoordinator(
            navigationController: navigationController,
            signInWithEmailUseCase: signInWithEmailUseCase,
            signInWithGoogleUseCase: signInWithGoogleUseCase,
            signUpWithEmailUseCase: signUpWithEmailUseCase,
            resetPasswordUseCase: resetPasswordUseCase,
            validator: validator 
        )
    }
}

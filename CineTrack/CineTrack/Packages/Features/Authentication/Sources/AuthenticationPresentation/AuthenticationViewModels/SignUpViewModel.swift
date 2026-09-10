//
//  SignUpViewModel.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import AuthenticationDomain
import AuthenticationPresentationAPI
import Foundation
import Observation

@Observable
@MainActor
public final class SignUpViewModel: SignUpViewModelProtocol {

    // MARK: - State

    public var username = ""
    public var email = ""
    public var password = ""
    public var confirmPassword = ""
    public var isLoading = false
    public var errorMessage: String?

    // MARK: - Dependencies

    internal let signUpWithEmailUseCase: SignUpWithEmailUseCaseProtocol
    internal let validateSignUpUseCase: ValidateSignUpUseCaseProtocol

    // MARK: - Actions

    public var onSignIn: (() -> Void)?
    public var onAuthenticated: (() -> Void)?

    // MARK: - Initialization

    public init(
        signUpWithEmailUseCase: SignUpWithEmailUseCaseProtocol,
        validateSignUpUseCase: ValidateSignUpUseCaseProtocol
    ) {
        self.signUpWithEmailUseCase = signUpWithEmailUseCase
        self.validateSignUpUseCase = validateSignUpUseCase
    }

}

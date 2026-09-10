//
//  SignInViewModel.swift
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
public final class SignInViewModel: SignInViewModelProtocol {

    // MARK: - State

    public var email = ""
    public var password = ""
    public var isLoading = false
    public internal(set) var isEmailLoading = false
    public internal(set) var isGoogleLoading = false
    public var errorMessage: String?

    public var forgotPasswordEmail = ""
    public var isForgotPasswordPresented = false
    public var forgotPasswordSuccessMessage: String?
    public var forgotPasswordErrorMessage: String?

    // MARK: - Dependencies

    internal let signInWithEmailUseCase: SignInWithEmailUseCaseProtocol
    internal let signInWithGoogleUseCase: SignInWithGoogleUseCaseProtocol
    internal let resetPasswordUseCase: ResetPasswordUseCaseProtocol

    // MARK: - Actions

    public var onSignUp: (() -> Void)?
    public var onAuthenticated: (() -> Void)?

    // MARK: - Initialization

    public init(
        signInWithEmailUseCase: SignInWithEmailUseCaseProtocol,
        signInWithGoogleUseCase: SignInWithGoogleUseCaseProtocol,
        resetPasswordUseCase: ResetPasswordUseCaseProtocol
    ) {
        self.signInWithEmailUseCase = signInWithEmailUseCase
        self.signInWithGoogleUseCase = signInWithGoogleUseCase
        self.resetPasswordUseCase = resetPasswordUseCase
    }

}

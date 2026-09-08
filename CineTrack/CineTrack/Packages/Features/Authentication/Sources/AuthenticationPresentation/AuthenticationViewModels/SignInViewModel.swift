//
//  SignInViewModel.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import AuthenticationDomain
import AuthenticationPresentationAPI
import Foundation

@MainActor
public protocol SignInViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    var isLoading: Bool { get set}
    var isEmailLoading: Bool { get }
    var isGoogleLoading: Bool { get }
    var errorMessage: String? { get set }

    var forgotPasswordEmail: String { get set }
    var isForgotPasswordPresented: Bool { get set }
    var forgotPasswordSuccessMessage: String? { get set }
    var forgotPasswordErrorMessage: String? { get set }

    func navigateToSignUp()
    
    func signInWithEmail() async
    func signInWithGoogle() async
    func sendResetPasswordLink() async
    
}

public final class SignInViewModel: SignInViewModelProtocol {

    // MARK: - Published Properties
    @Published public var email = ""
    @Published public var password = ""
    @Published public var isLoading = false
    @Published public private(set) var isEmailLoading = false
    @Published public private(set) var isGoogleLoading = false
    @Published public var errorMessage: String?
    
    @Published public var forgotPasswordEmail = ""
    @Published public var isForgotPasswordPresented = false
    @Published public var forgotPasswordSuccessMessage: String?
    @Published public var forgotPasswordErrorMessage: String?

    // MARK: - Dependencies
    private let signInWithEmailUseCase: SignInWithEmailUseCaseProtocol
    private let signInWithGoogleUseCase: SignInWithGoogleUseCaseProtocol
    private let resetPasswordUseCase: ResetPasswordUseCaseProtocol
    private let coordinator: AuthenticationNavigationProtocol

    // MARK: - Initializer
    public init(
        signInWithEmailUseCase: SignInWithEmailUseCaseProtocol,
        signInWithGoogleUseCase: SignInWithGoogleUseCaseProtocol,
        resetPasswordUseCase: ResetPasswordUseCaseProtocol,
        coordinator: AuthenticationNavigationProtocol
    ) {
        self.signInWithEmailUseCase = signInWithEmailUseCase
        self.signInWithGoogleUseCase = signInWithGoogleUseCase
        self.resetPasswordUseCase = resetPasswordUseCase
        self.coordinator = coordinator
    }

    // MARK: - Public Methods
    public func navigateToSignUp() {
        coordinator.showSignUp()
    }
    
    public func signInWithEmail() async {
        guard validateSignInFields() else { return }
        
        guard !isLoading else { return }
        isLoading = true
        isEmailLoading = true
        errorMessage = nil
        
        do {
            _ = try await signInWithEmailUseCase.execute(email: email, password: password)
            isLoading = false
            isEmailLoading = false
            
            coordinator.onFinish?()
        } catch {
            isLoading = false
            isEmailLoading = false
            errorMessage = mapFirebaseError(error)
        }
    }

    public func signInWithGoogle() async {
        guard !isLoading else { return }
        isLoading = true
        isGoogleLoading = true
        errorMessage = nil
        
        do {
            _ = try await signInWithGoogleUseCase.execute()
            isLoading = false
            isGoogleLoading = false
            
            coordinator.onFinish?()
        } catch {
            isLoading = false
            isGoogleLoading = false
            errorMessage = error.localizedDescription
        }
    }
    
    public func sendResetPasswordLink() async {
        guard validateForgotPasswordEmail() else { return }
        
        isLoading = true
        forgotPasswordErrorMessage = nil
        forgotPasswordSuccessMessage = nil
        
        do {
            try await resetPasswordUseCase.execute(email: forgotPasswordEmail)
            isLoading = false
            forgotPasswordSuccessMessage = AuthenticationStrings.ForgotPassword.successMessage
            forgotPasswordEmail = ""
        } catch {
            isLoading = false
            forgotPasswordErrorMessage = mapFirebaseError(error)
        }
    }
    
    // MARK: - Private Helpers (Validation & Error Mapping)
    private func validateSignInFields() -> Bool {
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || password.isEmpty {
            errorMessage = AuthenticationStrings.Errors.emptyFields
            return false
        }
        return true
    }
    
    private func validateForgotPasswordEmail() -> Bool {
        if forgotPasswordEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            forgotPasswordErrorMessage = AuthenticationStrings.Errors.emptyFields
            return false
        }
        return true
    }
    
    private func mapFirebaseError(_ error: Error) -> String {
        let nsError = error as NSError
        switch nsError.code {
        case 17011:
            return AuthenticationStrings.Errors.userNotFound
        case 17009:
            return AuthenticationStrings.Errors.wrongPassword
        case 17008: 
            return AuthenticationStrings.Errors.invalidEmail
        default:
            return error.localizedDescription
        }
    }
}

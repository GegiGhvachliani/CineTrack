//
//  SignUpViewModel.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import AuthenticationDomain
import AuthenticationPresentationAPI
import Foundation

@MainActor
public protocol SignUpViewModelProtocol: ObservableObject {
    var username: String { get set }
    var email: String { get set }
    var password: String { get set }
    var confirmPassword: String { get set }
    
    var isLoading: Bool { get set }
    var errorMessage: String? { get set }
    
    func navigateToSignIn()
    
    func signUpWithEmail() async
}

public final class SignUpViewModel: SignUpViewModelProtocol {
    
    // MARK: - Published Properties
   @Published public var username = ""
   @Published public var email = ""
   @Published public var password = ""
   @Published public var confirmPassword = ""
   @Published public var isLoading = false
   @Published public var errorMessage: String?
    
    // MARK: - Dependencies
    private let signUpWithEmailUseCase: SignUpWithEmailUseCaseProtocol
    private let validator: AuthenticationValidating
    private let coordinator: AuthenticationNavigationProtocol
    
    // MARK: - Initialization
    public init(
        signUpWithEmailUseCase: SignUpWithEmailUseCaseProtocol,
        validator: AuthenticationValidating,
        coordinator: AuthenticationNavigationProtocol
    ) {
        self.signUpWithEmailUseCase = signUpWithEmailUseCase
        self.validator = validator
        self.coordinator = coordinator
    }
    
    // MARK: - Public Methods
    public func navigateToSignIn() {
        coordinator.navigateBack()
    }
    
    public func signUpWithEmail() async {
        guard validateSignUpFields() else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            _ = try await signUpWithEmailUseCase.execute(email: email, username: username, password: password)
            isLoading = false
            
            coordinator.onFinish?()
        } catch {
            isLoading = false
            errorMessage = mapFirebaseError(error)        }
    }
    
    // MARK: - Private Helpers (Validation & Error Mapping)
    
    private func validateSignUpFields() -> Bool {
        if username.isEmpty || email.isEmpty || password.isEmpty {
            errorMessage = AuthenticationStrings.Errors.emptyFields
            return false
        }
        if !validator.validateEmail(email) {
            errorMessage = AuthenticationStrings.Errors.invalidEmail
            return false
        }
        if !validator.validatePasswordStrength(password) {
            errorMessage = AuthenticationStrings.Errors.shortPassword
            return false
        }
        if password != confirmPassword {
            errorMessage = AuthenticationStrings.Errors.passwordMismatch
            return false
        }
        return true
    }
    
    private func mapFirebaseError(_ error: Error) -> String {
        let nsError = error as NSError
        switch nsError.code {
        case 17007:
            return AuthenticationStrings.Errors.emailAlreadyInUse
        case 17008:
            return AuthenticationStrings.Errors.invalidEmail
        default:
            return error.localizedDescription
        }
    }
}

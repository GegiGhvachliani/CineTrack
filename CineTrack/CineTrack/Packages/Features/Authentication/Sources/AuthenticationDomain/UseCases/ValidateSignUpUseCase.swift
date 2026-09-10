import Foundation

public protocol ValidateSignUpUseCaseProtocol: Sendable {
    func execute(email: String, username: String, password: String, confirmPassword: String) throws
}

public final class ValidateSignUpUseCase: ValidateSignUpUseCaseProtocol {

    // MARK: - Dependencies

    private let validator: AuthenticationValidating

    // MARK: - Initialization

    public init(validator: AuthenticationValidating) {
        self.validator = validator
    }

    // MARK: - Execution

    public func execute(email: String, username: String, password: String, confirmPassword: String) throws {
        guard !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            !password.isEmpty
        else {
            throw AuthenticationError.emptyFields
        }

        guard validator.validateEmail(email) else {
            throw AuthenticationError.invalidEmail
        }

        guard validator.validatePasswordStrength(password) else {
            throw AuthenticationError.weakPassword
        }

        guard password == confirmPassword else {
            throw AuthenticationError.passwordMismatch
        }
    }
}

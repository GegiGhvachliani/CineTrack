import AuthenticationDomain
import AuthenticationPresentationAPI
import Foundation
import Observation

extension SignUpViewModel {

    // MARK: - Authentication

    public func signUpWithEmail() async {
        guard !isLoading, validateSignUpFields() else { return }

        isLoading = true
        errorMessage = nil

        do {
            _ = try await signUpWithEmailUseCase.execute(email: email, username: username, password: password)
            isLoading = false

            onAuthenticated?()
        } catch is CancellationError {
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = (error as? AuthenticationError)?.message ?? AuthenticationStrings.Errors.serviceUnavailable
        }
    }

    private func validateSignUpFields() -> Bool {
        do {
            try validateSignUpUseCase.execute(
                email: email,
                username: username,
                password: password,
                confirmPassword: confirmPassword
            )
            return true
        } catch {
            errorMessage = (error as? AuthenticationError)?.message ?? AuthenticationStrings.Errors.serviceUnavailable
            return false
        }
    }
}

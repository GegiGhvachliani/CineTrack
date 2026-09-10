import AuthenticationDomain
import AuthenticationPresentationAPI
import Foundation
import Observation

extension SignInViewModel {

    // MARK: - PasswordReset

    public func sendResetPasswordLink() async -> Bool {
        guard !isLoading, validateForgotPasswordEmail() else { return false }

        isLoading = true
        forgotPasswordErrorMessage = nil
        forgotPasswordSuccessMessage = nil

        do {
            try await resetPasswordUseCase.execute(email: forgotPasswordEmail)
            isLoading = false
            forgotPasswordSuccessMessage = AuthenticationStrings.ForgotPassword.successMessage
            forgotPasswordEmail = ""
            return true
        } catch is CancellationError {
            isLoading = false
            isEmailLoading = false
            isGoogleLoading = false
            return false
        } catch {
            isLoading = false
            forgotPasswordErrorMessage =
                (error as? AuthenticationError)?.message ?? AuthenticationStrings.Errors.serviceUnavailable
            return false
        }
    }

    private func validateForgotPasswordEmail() -> Bool {
        if forgotPasswordEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            forgotPasswordErrorMessage = AuthenticationStrings.Errors.emptyFields
            return false
        }
        return true
    }
}

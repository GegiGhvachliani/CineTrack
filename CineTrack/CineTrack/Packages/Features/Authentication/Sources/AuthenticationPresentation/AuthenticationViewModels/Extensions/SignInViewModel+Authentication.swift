import AuthenticationDomain
import AuthenticationPresentationAPI
import Foundation
import Observation

extension SignInViewModel {

    // MARK: - Authentication

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

            onAuthenticated?()
        } catch is CancellationError {
            isLoading = false
            isEmailLoading = false
            isGoogleLoading = false
        } catch {
            isLoading = false
            isEmailLoading = false
            errorMessage = (error as? AuthenticationError)?.message ?? AuthenticationStrings.Errors.serviceUnavailable
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

            onAuthenticated?()
        } catch is CancellationError {
            isLoading = false
            isEmailLoading = false
            isGoogleLoading = false
        } catch {
            isLoading = false
            isGoogleLoading = false
            errorMessage = (error as? AuthenticationError)?.message ?? AuthenticationStrings.Errors.serviceUnavailable
        }
    }

    private func validateSignInFields() -> Bool {
        if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || password.isEmpty {
            errorMessage = AuthenticationStrings.Errors.emptyFields
            return false
        }
        return true
    }
}

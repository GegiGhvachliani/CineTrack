import Observation

@Observable
@MainActor
final class MockSignInViewModel: SignInViewModelProtocol {

    // MARK: - Properties

    var email = ""
    var password = ""
    var isLoading = false
    var isEmailLoading = false
    var isGoogleLoading = false
    var errorMessage: String?

    var forgotPasswordEmail = ""
    var isForgotPasswordPresented = false
    var forgotPasswordSuccessMessage: String?
    var forgotPasswordErrorMessage: String?

    func signInWithEmail() async { print("Mock Sign In") }
    func signInWithGoogle() async { print("Mock Google Sign In") }
    func sendResetPasswordLink() async -> Bool { true }
    func navigateToSignUp() { print("Navigate to Sign Up") }
}

import Observation

@Observable
@MainActor
final class MockSignUpViewModel: SignUpViewModelProtocol {

    // MARK: - Properties

    var username = ""
    var email = ""
    var password = ""
    var confirmPassword = ""
    var isLoading = false
    var errorMessage: String?

    func signUpWithEmail() async { print("Mock Sign Up") }
    func navigateToSignIn() { print("Navigate to Sign In") }
}

import Observation

@MainActor
public protocol SignUpViewModelProtocol: AnyObject, Observable {
    var username: String { get set }
    var email: String { get set }
    var password: String { get set }
    var confirmPassword: String { get set }

    var isLoading: Bool { get set }
    var errorMessage: String? { get set }

    func navigateToSignIn()

    func signUpWithEmail() async
}

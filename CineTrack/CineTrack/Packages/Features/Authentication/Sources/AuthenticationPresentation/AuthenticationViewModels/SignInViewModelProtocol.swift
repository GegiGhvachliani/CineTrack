import Observation

@MainActor
public protocol SignInViewModelProtocol: AnyObject, Observable {
    var email: String { get set }
    var password: String { get set }
    var isLoading: Bool { get set }
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
    func sendResetPasswordLink() async -> Bool

}

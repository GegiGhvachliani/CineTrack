import AuthenticationDomain

public protocol AuthenticationServiceProtocol: Sendable {

    func isUserAuthenticated() -> Bool
    func signInWithEmail(email: String, password: String) async throws -> User
    func signUpWithEmail(email: String, username: String, password: String) async throws -> User
    func resetPassword(email: String) async throws

    @MainActor
    func signInWithGoogle() async throws -> User
}

import AuthenticationDomain

public final class AuthenticationRepository: AuthenticationRepositoryProtocol {

    // MARK: - Dependencies

    private let service: AuthenticationServiceProtocol

    // MARK: - Initialization

    public init(service: AuthenticationServiceProtocol) {
        self.service = service
    }

    // MARK: - Authentication

    public func isUserAuthenticated() -> Bool {
        service.isUserAuthenticated()
    }

    public func signInWithEmail(email: String, password: String) async throws -> User {
        try await service.signInWithEmail(email: email, password: password)
    }

    public func signUpWithEmail(email: String, username: String, password: String) async throws -> User {
        try await service.signUpWithEmail(email: email, username: username, password: password)
    }

    @MainActor
    public func signInWithGoogle() async throws -> User {
        try await service.signInWithGoogle()
    }

    public func resetPassword(email: String) async throws {
        try await service.resetPassword(email: email)
    }
}

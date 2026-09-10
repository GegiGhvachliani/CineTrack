public protocol CheckAuthenticationStatusUseCaseProtocol: Sendable {
    func execute() -> Bool
}

public final class CheckAuthenticationStatusUseCase: CheckAuthenticationStatusUseCaseProtocol {

    // MARK: - Dependencies

    private let repository: AuthenticationRepositoryProtocol

    // MARK: - Initialization

    public init(repository: AuthenticationRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Execution

    public func execute() -> Bool {
        repository.isUserAuthenticated()
    }
}

import Foundation

public protocol SignOutUseCaseProtocol: Sendable {
    func execute() async throws
}

public final class SignOutUseCase: SignOutUseCaseProtocol {

    // MARK: - Dependencies

    private let repository: ProfileRepositoryProtocol

    // MARK: - Initialization

    public init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Execution

    public func execute() async throws {
        try await repository.signOut()
    }
}

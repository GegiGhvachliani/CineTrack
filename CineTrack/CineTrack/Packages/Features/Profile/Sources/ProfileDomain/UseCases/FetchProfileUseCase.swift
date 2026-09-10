import Foundation

public protocol FetchProfileUseCaseProtocol: Sendable {
    func execute() async throws -> ProfileAccount
}

public final class FetchProfileUseCase: FetchProfileUseCaseProtocol {

    // MARK: - Dependencies

    private let repository: ProfileRepositoryProtocol

    // MARK: - Initialization

    public init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Execution

    public func execute() async throws -> ProfileAccount {
        try await repository.fetchAccount()
    }
}

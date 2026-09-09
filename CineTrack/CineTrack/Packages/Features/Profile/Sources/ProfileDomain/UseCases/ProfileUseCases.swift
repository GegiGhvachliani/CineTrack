import Foundation

public struct FetchProfileUseCase: Sendable {
    private let repository: ProfileRepositoryProtocol
    public init(repository: ProfileRepositoryProtocol) { self.repository = repository }
    public func execute() async throws -> ProfileAccount { try await repository.fetchAccount() }
}

public struct UpdateProfilePhotoUseCase: Sendable {
    private let repository: ProfileRepositoryProtocol
    public init(repository: ProfileRepositoryProtocol) { self.repository = repository }
    public func execute(data: Data) async throws { try await repository.updatePhoto(data) }
}

public struct SignOutUseCase: Sendable {
    private let repository: ProfileRepositoryProtocol
    public init(repository: ProfileRepositoryProtocol) { self.repository = repository }
    public func execute() async throws { try await repository.signOut() }
}

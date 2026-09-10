import Foundation

public protocol UpdateProfilePhotoUseCaseProtocol: Sendable {
    func execute(data: Data) async throws -> Data
}

public final class UpdateProfilePhotoUseCase: UpdateProfilePhotoUseCaseProtocol {

    // MARK: - Dependencies

    private let repository: ProfileRepositoryProtocol

    // MARK: - Initialization

    public init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Execution

    public func execute(data: Data) async throws -> Data {
        try await repository.updatePhoto(data)
    }
}

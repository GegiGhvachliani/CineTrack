import SharedCore

@MainActor
public protocol FetchSeeAllPageUseCaseProtocol {
    func execute() async -> SeeAllPayload?
}

public final class FetchSeeAllPageUseCase: FetchSeeAllPageUseCaseProtocol {

    // MARK: - Dependencies

    private let repository: SeeAllRepositoryProtocol

    // MARK: - Initialization

    public init(repository: SeeAllRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Execution

    public func execute() async -> SeeAllPayload? {
        await repository.fetchNextPage()
    }
}

import SharedCore

public protocol FetchNewsDetailsUseCaseProtocol: Sendable {
    func execute() -> News
}

public final class FetchNewsDetailsUseCase: FetchNewsDetailsUseCaseProtocol {

    // MARK: - Dependencies

    private let repository: NewsDetailsRepositoryProtocol

    // MARK: - Initialization

    public init(repository: NewsDetailsRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Execution

    public func execute() -> News {
        repository.fetchArticle()
    }
}

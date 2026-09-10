import SharedCore

public protocol FetchMovieNewsUseCaseProtocol: Sendable {
    func execute(movieTitle: String) async throws -> [News]
}

public struct FetchMovieNewsUseCase: FetchMovieNewsUseCaseProtocol {

    // MARK: - Properties

    private let repository: MovieDetailsRepositoryProtocol

    // MARK: - Initialization

    public init(repository: MovieDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(movieTitle: String) async throws -> [News] {
        try await repository.fetchNews(movieTitle: movieTitle)
    }
}

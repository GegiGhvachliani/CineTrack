import SharedCore

public protocol FetchMovieNewsUseCaseProtocol: Sendable {
    func execute(movieTitle: String) async throws -> [News]
}

public struct FetchMovieNewsUseCase: FetchMovieNewsUseCaseProtocol {
    private let repository: MovieDetailsRepositoryProtocol

    public init(repository: MovieDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(movieTitle: String) async throws -> [News] {
        try await repository.fetchNews(movieTitle: movieTitle)
    }
}

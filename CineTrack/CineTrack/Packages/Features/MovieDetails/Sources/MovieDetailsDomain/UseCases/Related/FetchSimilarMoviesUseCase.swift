import SharedCore

public protocol FetchSimilarMoviesUseCaseProtocol: Sendable {
    func execute(movieID: Int, page: Int) async throws -> [Movie]
}

public struct FetchSimilarMoviesUseCase: FetchSimilarMoviesUseCaseProtocol {

    // MARK: - Properties

    private let repository: MovieDetailsRepositoryProtocol

    // MARK: - Initialization

    public init(repository: MovieDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(movieID: Int, page: Int) async throws -> [Movie] {
        try await repository.fetchSimilarMovies(movieID: movieID, page: page)
    }
}

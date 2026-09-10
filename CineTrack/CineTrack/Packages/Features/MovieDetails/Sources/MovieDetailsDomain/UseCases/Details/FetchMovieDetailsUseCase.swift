public protocol FetchMovieDetailsUseCaseProtocol: Sendable {
    func execute(movieID: Int) async throws -> MovieDetails
}

public struct FetchMovieDetailsUseCase: FetchMovieDetailsUseCaseProtocol {

    // MARK: - Properties

    private let repository: MovieDetailsRepositoryProtocol

    // MARK: - Initialization

    public init(repository: MovieDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(movieID: Int) async throws -> MovieDetails {
        try await repository.fetchMovieDetails(movieID: movieID)
    }
}

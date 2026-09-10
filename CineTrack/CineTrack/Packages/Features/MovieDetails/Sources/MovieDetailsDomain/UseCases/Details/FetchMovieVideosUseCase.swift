import SharedCore

public protocol FetchMovieVideosUseCaseProtocol: Sendable {
    func execute(movieID: Int) async throws -> [MovieVideo]
}

public struct FetchMovieVideosUseCase: FetchMovieVideosUseCaseProtocol {

    // MARK: - Properties

    private let repository: MovieDetailsRepositoryProtocol

    // MARK: - Initialization

    public init(repository: MovieDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(movieID: Int) async throws -> [MovieVideo] {
        try await repository.fetchVideos(movieID: movieID)
    }
}

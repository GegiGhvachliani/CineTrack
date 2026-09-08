import SharedCore

public protocol FetchMovieVideosUseCaseProtocol: Sendable {
    func execute(movieID: Int) async throws -> [MovieVideo]
}

public struct FetchMovieVideosUseCase: FetchMovieVideosUseCaseProtocol {
    private let repository: MovieDetailsRepositoryProtocol

    public init(repository: MovieDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(movieID: Int) async throws -> [MovieVideo] {
        try await repository.fetchVideos(movieID: movieID)
    }
}

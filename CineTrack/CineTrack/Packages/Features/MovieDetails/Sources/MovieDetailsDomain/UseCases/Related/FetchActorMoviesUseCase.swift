import SharedCore

public protocol FetchActorMoviesUseCaseProtocol: Sendable {
    func execute(actorID: Int) async throws -> [Movie]
}

public struct FetchActorMoviesUseCase: FetchActorMoviesUseCaseProtocol {
    private let repository: MovieDetailsRepositoryProtocol

    public init(repository: MovieDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(actorID: Int) async throws -> [Movie] {
        try await repository.fetchMovies(for: actorID)
    }
}

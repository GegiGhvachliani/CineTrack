import SharedCore

public protocol FetchWatchlistedMoviesUseCaseProtocol: Sendable {
    func execute() async throws -> [Movie]
}

public final class FetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol, @unchecked Sendable {
    private let repository: WatchlistRepositoryProtocol

    public init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    public func execute() async throws -> [Movie] {
        try await repository.fetchWatchlistedMovies()
    }
}

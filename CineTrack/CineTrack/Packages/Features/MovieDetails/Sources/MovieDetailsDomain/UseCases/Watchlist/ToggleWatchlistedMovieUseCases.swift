import SharedCore

public protocol AddWatchlistedMovieUseCaseProtocol: Sendable {
    func execute(_ movie: Movie) async throws
}

public final class AddWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol, @unchecked Sendable {
    private let repository: WatchlistRepositoryProtocol

    public init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(_ movie: Movie) async throws {
        try await repository.addWatchlistedMovie(movie)
    }
}

public protocol RemoveWatchlistedMovieUseCaseProtocol: Sendable {
    func execute(_ movie: Movie) async throws
}

public final class RemoveWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol, @unchecked Sendable {
    private let repository: WatchlistRepositoryProtocol

    public init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(_ movie: Movie) async throws {
        try await repository.removeWatchlistedMovie(movie)
    }
}

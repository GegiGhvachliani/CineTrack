import SharedCore

public protocol WatchlistRepositoryProtocol: Sendable {
    func fetchWatchlistedMovies() async throws -> [Movie]
    func addWatchlistedMovie(_ movie: Movie) async throws
    func removeWatchlistedMovie(_ movie: Movie) async throws
}

import MovieDetailsDomain
import SharedAuth
import SharedCore
import SharedStorage

public final class WatchlistRepository: WatchlistRepositoryProtocol, @unchecked Sendable {
    private let firestore: RemoteDocumentStore
    private let userSession: UserSession

    public init(firestore: RemoteDocumentStore, userSession: UserSession) {
        self.firestore = firestore
        self.userSession = userSession
    }

    public func fetchWatchlistedMovies() async throws -> [Movie] {
        try await firestore.getCollection(
            FirestoreMovieDTO.self,
            collection: try collectionPath()
        ).map { $0.toDomain() }
    }

    public func addWatchlistedMovie(_ movie: Movie) async throws {
        try await firestore.set(
            FirestoreMovieDTO(movie: movie),
            collection: try collectionPath(),
            documentID: String(movie.id)
        )
    }

    public func removeWatchlistedMovie(_ movie: Movie) async throws {
        try await firestore.delete(
            collection: try collectionPath(),
            documentID: String(movie.id)
        )
    }

    private func collectionPath() throws -> String {
        guard let userID = userSession.currentUserID else {
            throw FirestoreError.unauthenticated
        }

        return "users/\(userID)/watchlist"
    }
}

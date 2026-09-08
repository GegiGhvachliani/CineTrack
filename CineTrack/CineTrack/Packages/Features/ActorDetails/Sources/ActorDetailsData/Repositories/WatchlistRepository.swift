//
//  WatchlistRepository.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//


import ActorDetailsDomain
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
        let movies = try await firestore.getCollection(
            FirestoreMovieDTO.self,
            collection: try collectionPath()
        )

        return movies.map { $0.toDomain() }
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

//
//  WatchlistRepository.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import Foundation

import LibraryDomain
import SharedAuth
import SharedCore
import SharedStorage

public final class WatchlistRepository: WatchlistRepositoryProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let firestore: RemoteDocumentStore  // მთავაზობს მეთოდებს , set, get, getCollection, delete
    private let userSession: UserSession  // მეუბნება ვინ არის ახლა შესული

    // MARK: - Initialization

    public init(
        firestore: RemoteDocumentStore,
        userSession: UserSession
    ) {
        self.firestore = firestore
        self.userSession = userSession
    }

    // MARK: - Fetch

    public func fetchWatchlistedMovies() async throws -> [Movie] {

        let userID = try currentUserID()

        let collection = "users/\(userID)/watchlist"

        let dtos = try await firestore.getCollection(FirestoreMovieDTO.self, collection: collection)

        return dtos.map { $0.toDomain() }

    }

    // MARK: - Add

    public func addWatchlistedMovie(movie: Movie) async throws {

        let userID = try currentUserID()

        let collection = "users/\(userID)/watchlist"

        let dto = FirestoreMovieDTO(movie: movie)

        try await firestore.set(dto, collection: collection, documentID: String(movie.id))
    }

    // MARK: - Remove

    public func removeWatchlistedMovie(movie: Movie) async throws {

        let userID = try currentUserID()

        let collection = "users/\(userID)/watchlist"

        try await firestore.delete(collection: collection, documentID: String(movie.id))

    }

    // MARK: - User

    private func currentUserID() throws -> String {

        guard let userID = userSession.currentUserID else {
            throw FirestoreError.unauthenticated
        }

        return userID
    }
}

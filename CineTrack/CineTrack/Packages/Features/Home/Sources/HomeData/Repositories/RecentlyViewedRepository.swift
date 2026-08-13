//
//  RecentlyViewedRepository.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

import HomeDomain
import SharedAuth
import SharedStorage

public final class RecentlyViewedRepository: RecentlyViewedRepositoryProtocol, @unchecked Sendable {

    private let firestore: RemoteDocumentStore
    private let userSession: UserSession

    private let moviesCollection = "recentlyViewedMovies"

    private let actorsCollection = "recentlyViewedActors"

    public init(
        firestore: RemoteDocumentStore,
        userSession: UserSession
    ) {
        self.firestore = firestore
        self.userSession = userSession
    }

    // MARK: - Movies

    public func fetchRecentlyViewedMovies() async throws -> [RecentlyViewedMovie] {

        let userID = try currentUserID()

        let collection = "users/\(userID)/\(moviesCollection)"

        let dtos = try await firestore.getCollection(RecentlyViewedMovieDTO.self, collection: collection)

        return dtos .sorted { $0.viewedAt > $1.viewedAt }
                    .map { $0.toDomain() }
    }

    public func addRecentlyViewedMovie(_ movie: RecentlyViewedMovie) async throws {

        let userID = try currentUserID()

        let collection = "users/\(userID)/\(moviesCollection)"

        let dto = RecentlyViewedMovieDTO(movie: movie)

        try await firestore.set(dto, collection: collection, documentID: String(movie.id))
    }

    // MARK: - Actors

    public func fetchRecentlyViewedActors() async throws -> [RecentlyViewedActor] {

        let userID = try currentUserID()

        let collection = "users/\(userID)/\(actorsCollection)"

        let dtos = try await firestore.getCollection(RecentlyViewedActorDTO.self, collection: collection)

        return dtos.sorted { $0.viewedAt > $1.viewedAt}
                    .map { $0.toDomain() }
    }

    public func addRecentlyViewedActor(_ actor: RecentlyViewedActor) async throws {

        let userID = try currentUserID()

        let collection = "users/\(userID)/\(actorsCollection)"

        let dto = RecentlyViewedActorDTO(actor: actor)

        try await firestore.set(dto, collection: collection, documentID: String(actor.id))
    }
    
    // MARK: - Clear History

    public func clearRecentlyViewed() async throws {

        let userID = try currentUserID()

        let moviesCollection = "users/\(userID)/\(self.moviesCollection)"

        let actorsCollection = "users/\(userID)/\(self.actorsCollection)"

        let movieDTOs = try await firestore.getCollection(RecentlyViewedMovieDTO.self, collection: moviesCollection)

        let actorDTOs = try await firestore.getCollection(RecentlyViewedActorDTO.self, collection: actorsCollection)

        try await withThrowingTaskGroup(of: Void.self) { group in

            for movie in movieDTOs {
                group.addTask {
                    try await self.firestore.delete(
                        collection: moviesCollection,
                        documentID: String(movie.id)
                    )
                }
            }

            for actor in actorDTOs {
                group.addTask {
                    try await self.firestore.delete(
                        collection: actorsCollection,
                        documentID: String(actor.id)
                    )
                }
            }

            try await group.waitForAll()
        }
    }


    // MARK: - User

    private func currentUserID() throws -> String {

        guard let userID = userSession.currentUserID else {
            throw RecentlyViewedRepositoryError
                .userNotAuthenticated
        }

        return userID
    }
}

// MARK: - Error

private enum RecentlyViewedRepositoryError: LocalizedError {

    case userNotAuthenticated

    var errorDescription: String? {

        switch self {

        case .userNotAuthenticated:
            return "User is not authenticated."
        }
    }
}

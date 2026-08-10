//
//  FavouriteRepository.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//


import Foundation

import HomeDomain
import SharedAuth
import SharedStorage

public final class FavouriteRepository:
    FavouriteRepositoryProtocol,
    @unchecked Sendable
{
    private let firestore: RemoteDocumentStore
    private let userSession: UserSession

    public init(
        firestore: RemoteDocumentStore,
        userSession: UserSession
    ) {
        self.firestore = firestore
        self.userSession = userSession
    }

    // MARK: - Fetch

    public func fetchFavouritedActorIDs()
        async throws
        -> Set<Int>
    {
        let userID = try currentUserID()

        let collection =
            "users/\(userID)/favourites"

        let dtos =
            try await firestore.getCollection(
                FirestoreEntityIDDTO.self,
                collection: collection
            )

        return Set(
            dtos.map(\.id)
        )
    }

    // MARK: - Add

    public func addFavouritedActor(
        id: Int
    ) async throws {

        let userID = try currentUserID()

        let collection =
            "users/\(userID)/favourites"

        let dto =
            FirestoreEntityIDDTO(
                id: id
            )

        try await firestore.set(
            dto,
            collection: collection,
            documentID: String(id)
        )
    }

    // MARK: - Remove

    public func removeFavouritedActor(
        id: Int
    ) async throws {

        let userID = try currentUserID()

        let collection =
            "users/\(userID)/favourites"

        try await firestore.delete(
            collection: collection,
            documentID: String(id)
        )
    }

    // MARK: - User

    private func currentUserID() throws -> String {

        guard
            let userID = userSession.currentUserID
        else {
            throw FirestoreError.unauthenticated
        }

        return userID
    }
}
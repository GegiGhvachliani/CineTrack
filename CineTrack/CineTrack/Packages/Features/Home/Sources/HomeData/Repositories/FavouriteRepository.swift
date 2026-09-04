//
//  FavouriteRepository.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import Foundation
import HomeDomain
import SharedAuth
import SharedCore
import SharedStorage

public final class FavouriteRepository: FavouriteRepositoryProtocol, @unchecked Sendable {
    
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

    public func fetchFavouritedActors() async throws -> [Actor] {
        
        let userID = try currentUserID()

        let collection = "users/\(userID)/favourites"
        print("📥 Loading favourites for user:", userID)
        let dtos = try await firestore.getCollection(FavouritedActorDTO.self, collection: collection)
        print("📥 Favourite documents found:", dtos.count)
        return dtos.map { $0.toDomain() }
    }

    // MARK: - Add

    public func addFavouritedActor(actor: Actor) async throws {

        let userID = try currentUserID()

        let collection = "users/\(userID)/favourites"
        print("📤 Saving favourite:", actor.name, "for user:", userID)
        let dto = FavouritedActorDTO(actor: actor)

        try await firestore.set(dto, collection: collection, documentID: String(actor.id))
        print("✅ Favourite saved:", actor.name)
    }

    // MARK: - Remove

    public func removeFavouritedActor(actor: Actor) async throws {

        let userID = try currentUserID()

        let collection = "users/\(userID)/favourites"

        try await firestore.delete(collection: collection, documentID: String(actor.id))
    }

    // MARK: - User

    private func currentUserID() throws -> String {

        guard let userID = userSession.currentUserID else {
            throw FirestoreError.unauthenticated
        }

        return userID
    }
}

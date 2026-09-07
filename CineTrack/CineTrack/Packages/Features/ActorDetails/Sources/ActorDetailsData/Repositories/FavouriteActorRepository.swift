import ActorDetailsDomain
import SharedAuth
import SharedCore
import SharedStorage

public final class FavouriteActorRepository: FavouriteActorRepositoryProtocol, @unchecked Sendable {
    private let firestore: RemoteDocumentStore
    private let userSession: UserSession

    public init(firestore: RemoteDocumentStore, userSession: UserSession) {
        self.firestore = firestore
        self.userSession = userSession
    }

    public func fetchFavouritedActors() async throws -> [Actor] {
        let actors = try await firestore.getCollection(
            FavouritedActorDTO.self,
            collection: try collectionPath()
        )
        return actors.map { $0.toDomain() }
    }

    public func addFavouritedActor(_ actor: Actor) async throws {
        try await firestore.set(
            FavouritedActorDTO(actor: actor),
            collection: try collectionPath(),
            documentID: String(actor.id)
        )
    }

    public func removeFavouritedActor(_ actor: Actor) async throws {
        try await firestore.delete(collection: try collectionPath(), documentID: String(actor.id))
    }

    private func collectionPath() throws -> String {
        guard let userID = userSession.currentUserID else {
            throw FirestoreError.unauthenticated
        }
        return "users/\(userID)/favourites"
    }
}

import SharedCore

public protocol FavouriteActorRepositoryProtocol: Sendable {
    func fetchFavouritedActors() async throws -> [Actor]
    func addFavouritedActor(_ actor: Actor) async throws
    func removeFavouritedActor(_ actor: Actor) async throws
}

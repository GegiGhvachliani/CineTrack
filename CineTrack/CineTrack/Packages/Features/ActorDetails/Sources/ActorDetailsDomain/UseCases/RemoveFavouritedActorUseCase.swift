import SharedCore

public protocol RemoveFavouritedActorUseCaseProtocol: Sendable {
    func execute(_ actor: Actor) async throws
}

public final class RemoveFavouritedActorUseCase: RemoveFavouritedActorUseCaseProtocol, @unchecked Sendable {
    private let repository: FavouriteActorRepositoryProtocol

    public init(repository: FavouriteActorRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(_ actor: Actor) async throws {
        try await repository.removeFavouritedActor(actor)
    }
}

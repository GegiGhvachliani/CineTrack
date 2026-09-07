import SharedCore

public protocol AddFavouritedActorUseCaseProtocol: Sendable {
    func execute(_ actor: Actor) async throws
}

public final class AddFavouritedActorUseCase: AddFavouritedActorUseCaseProtocol, @unchecked Sendable {
    private let repository: FavouriteActorRepositoryProtocol

    public init(repository: FavouriteActorRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(_ actor: Actor) async throws {
        try await repository.addFavouritedActor(actor)
    }
}

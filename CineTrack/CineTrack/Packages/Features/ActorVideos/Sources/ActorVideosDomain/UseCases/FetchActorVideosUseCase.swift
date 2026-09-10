import SharedCore

public protocol FetchActorVideosUseCaseProtocol: Sendable {
    func execute(movieIDs: [Int]) async throws -> [ActorVideo]
}

public final class FetchActorVideosUseCase: FetchActorVideosUseCaseProtocol {

    // MARK: - Properties

    private let repository: ActorVideosRepositoryProtocol

    // MARK: - Initialization

    public init(repository: ActorVideosRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(movieIDs: [Int]) async throws -> [ActorVideo] {
        try await repository.fetchVideos(movieIDs: movieIDs)
    }
}

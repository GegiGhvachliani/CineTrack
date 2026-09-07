import Foundation

public struct ActorMediaImage: Identifiable, Sendable, Equatable {
    public let id: String
    public let url: URL
    public let aspectRatio: Double
    public init(id: String, url: URL, aspectRatio: Double) { self.id = id; self.url = url; self.aspectRatio = aspectRatio }
}

public struct ActorMediaPage: Sendable {
    public let images: [ActorMediaImage]
    public let nextToken: String?
    public init(images: [ActorMediaImage], nextToken: String?) { self.images = images; self.nextToken = nextToken }
}

public protocol ActorMediaRepositoryProtocol: Sendable {
    func fetchImages(actorName: String, continuation: String?) async throws -> ActorMediaPage
}

public protocol FetchActorMediaUseCaseProtocol: Sendable {
    func execute(actorName: String, continuation: String?) async throws -> ActorMediaPage
}

public struct FetchActorMediaUseCase: FetchActorMediaUseCaseProtocol {
    private let repository: ActorMediaRepositoryProtocol
    public init(repository: ActorMediaRepositoryProtocol) { self.repository = repository }
    public func execute(actorName: String, continuation: String?) async throws -> ActorMediaPage { try await repository.fetchImages(actorName: actorName, continuation: continuation) }
}

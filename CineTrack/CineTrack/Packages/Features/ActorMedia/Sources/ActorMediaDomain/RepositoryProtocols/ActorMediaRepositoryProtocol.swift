import Foundation

public protocol ActorMediaRepositoryProtocol: Sendable {
    func fetchImages(actorName: String, continuation: String?) async throws -> ActorMediaPage
}

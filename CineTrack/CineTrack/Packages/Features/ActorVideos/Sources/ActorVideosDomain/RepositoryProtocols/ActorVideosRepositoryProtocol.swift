import SharedCore

public protocol ActorVideosRepositoryProtocol: Sendable {
    func fetchVideos(movieIDs: [Int]) async throws -> [ActorVideo]
}

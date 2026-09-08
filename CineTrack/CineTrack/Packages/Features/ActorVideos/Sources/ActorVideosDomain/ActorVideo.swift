import SharedCore

public struct ActorVideo: Identifiable, Equatable, Sendable {
    public let movieID: Int
    public let video: MovieVideo

    public var id: String {
        "\(movieID)-\(video.id)"
    }

    public init(movieID: Int, video: MovieVideo) {
        self.movieID = movieID
        self.video = video
    }
}

public protocol ActorVideosRepositoryProtocol: Sendable {
    func fetchVideos(movieIDs: [Int]) async throws -> [ActorVideo]
}

public protocol FetchActorVideosUseCaseProtocol: Sendable {
    func execute(movieIDs: [Int]) async throws -> [ActorVideo]
}

public struct FetchActorVideosUseCase: FetchActorVideosUseCaseProtocol {
    private let repository: ActorVideosRepositoryProtocol

    public init(repository: ActorVideosRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(movieIDs: [Int]) async throws -> [ActorVideo] {
        try await repository.fetchVideos(movieIDs: movieIDs)
    }
}

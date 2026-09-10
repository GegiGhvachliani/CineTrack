import SharedCore

public protocol FetchPlaylistVideosUseCaseProtocol: Sendable {
    func execute(context: VideoPlaylistContext) async throws -> [MovieVideo]
}

public final class FetchPlaylistVideosUseCase: FetchPlaylistVideosUseCaseProtocol {

    // MARK: - Dependencies

    private let repository: VideosListRepositoryProtocol

    // MARK: - Initialization

    public init(repository: VideosListRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Execution

    public func execute(context: VideoPlaylistContext) async throws -> [MovieVideo] {
        let videos = try await repository.fetchVideos(movieID: context.movie.id)
        let selectedVideo = context.selectedVideo
        let includesSelectedVideo = videos.contains { $0.id == selectedVideo.id }
        let playlist = includesSelectedVideo ? videos : [selectedVideo] + videos
        var seenVideoIDs = Set<String>()

        return playlist.filter {
            seenVideoIDs.insert($0.id).inserted
        }
    }
}

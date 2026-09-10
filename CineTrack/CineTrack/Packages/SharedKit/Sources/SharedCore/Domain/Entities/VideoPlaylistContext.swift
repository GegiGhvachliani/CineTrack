import Foundation

public struct VideoPlaylistContext: Sendable, Equatable {

    // MARK: - Properties

    public let movie: Movie
    public let selectedVideo: MovieVideo
    public let source: VideoPlaylistSource

    // MARK: - Initialization

    public init(
        movie: Movie,
        selectedVideo: MovieVideo,
        source: VideoPlaylistSource
    ) {
        self.movie = movie
        self.selectedVideo = selectedVideo
        self.source = source
    }
}

public enum VideoPlaylistSource: Sendable, Equatable {
    case home
    case movieDetails
    case actorDetails
}

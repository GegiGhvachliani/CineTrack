import SharedCore

@MainActor
public protocol VideosListRoutingProtocol: AnyObject {
    func showMovieDetails(from context: VideoPlaylistContext)
}

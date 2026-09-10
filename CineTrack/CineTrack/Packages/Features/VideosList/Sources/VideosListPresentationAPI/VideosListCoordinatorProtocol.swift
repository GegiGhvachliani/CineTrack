import Foundation
import SharedCore

public protocol VideosListCoordinatorProtocol: Coordinator {
    func showMovieDetails(context: VideoPlaylistContext)
    func close()
}

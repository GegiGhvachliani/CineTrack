import UIKit
import SharedCore

@MainActor
public protocol VideosListFactoryProtocol {

    func makeVideosListCoordinator(
        context: VideoPlaylistContext,
        navigationController: UINavigationController,
        router: VideosListRoutingProtocol
    ) -> VideosListCoordinatorProtocol

    func makeVideosListViewController(
        context: VideoPlaylistContext,
        coordinator: VideosListCoordinatorProtocol
    ) -> UIViewController
}

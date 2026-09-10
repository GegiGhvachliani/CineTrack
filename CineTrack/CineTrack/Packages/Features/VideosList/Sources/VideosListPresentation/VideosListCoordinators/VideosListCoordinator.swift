import UIKit

import VideosListPresentationAPI
import SharedCore

public final class VideosListCoordinator: VideosListCoordinatorProtocol {

    // MARK: - Children

    public var childCoordinators: [Coordinator] = []

    // MARK: - Dependencies

    private let context: VideoPlaylistContext
    private let navigationController: UINavigationController
    private let factory: VideosListFactoryProtocol
    private weak var router: VideosListRoutingProtocol?

    // MARK: - Initialization

    public init(
        context: VideoPlaylistContext,
        navigationController: UINavigationController,
        factory: VideosListFactoryProtocol,
        router: VideosListRoutingProtocol
    ) {
        self.context = context
        self.navigationController = navigationController
        self.factory = factory
        self.router = router
    }

    // MARK: - Navigation

    public func start() {
        let viewController = factory.makeVideosListViewController(context: context, coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }

    public func showMovieDetails(context: VideoPlaylistContext) {
        router?.showMovieDetails(from: context)
    }

    public func close() {
        navigationController.popViewController(animated: true)
    }
}

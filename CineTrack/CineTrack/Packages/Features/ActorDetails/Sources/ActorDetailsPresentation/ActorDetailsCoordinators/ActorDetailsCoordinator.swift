import UIKit

import ActorDetailsDomain
import ActorDetailsPresentationAPI
import SharedCore

public final class ActorDetailsCoordinator: ActorDetailsCoordinatorProtocol {
    public var childCoordinators: [Coordinator] = []

    private let actorID: Int
    private let navigationController: UINavigationController
    private let factory: ActorDetailsFactoryProtocol
    private weak var router: ActorDetailsRoutingProtocol?

    public init(
        actorID: Int,
        navigationController: UINavigationController,
        factory: ActorDetailsFactoryProtocol,
        router: ActorDetailsRoutingProtocol
    ) {
        self.actorID = actorID
        self.navigationController = navigationController
        self.factory = factory
        self.router = router
    }

    public func start() {
        let viewController = factory.makeActorDetailsViewController(
            actorID: actorID,
            onMovieDetails: { [weak self] movie in
                self?.router?.showMovieDetails(movie: movie)
            },
            onNewsDetails: { [weak self] news in
                self?.router?.showNewsDetails(news: news)
            },
            onShowAllPhotos: { [weak self] images, actorName in
                self?.showAllPhotos(images: images, actorName: actorName)
            },
            onShowMiniBiography: { [weak self] actor in
                self?.showMiniBiography(actor: actor)
            },
            onShowAllFilmography: { [weak self] in
                self?.router?.showSeeAll(section: .filmography)
            }
        )
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showAllPhotos(images: [ActorImage], actorName: String) {
        let viewController = factory.makeActorPhotosViewController(
            images: images,
            actorName: actorName
        )
        navigationController.pushViewController(viewController, animated: true)
    }

    private func showMiniBiography(actor: ActorDetails) {
        let viewController = factory.makeMiniBiographyViewController(actor: actor)
        navigationController.pushViewController(viewController, animated: true)
    }
}

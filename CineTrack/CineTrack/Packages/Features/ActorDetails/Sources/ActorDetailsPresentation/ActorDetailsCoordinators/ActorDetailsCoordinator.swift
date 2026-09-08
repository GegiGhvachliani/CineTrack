//
//  ActorDetailsCoordinator.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

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
        navigationController.setNavigationBarHidden(false, animated: true)

        let viewController = factory.makeActorDetailsViewController(
            actorID: actorID,
            onMovieDetails: { [weak self] movie in
                self?.router?.showMovieDetails(movie: movie)
            },
            onNewsDetails: { [weak self] news in
                self?.router?.showNewsDetails(news: news)
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

    private func showMiniBiography(actor: ActorDetails) {
        let viewController = factory.makeMiniBiographyViewController(actor: actor)
        navigationController.pushViewController(viewController, animated: true)
    }
}

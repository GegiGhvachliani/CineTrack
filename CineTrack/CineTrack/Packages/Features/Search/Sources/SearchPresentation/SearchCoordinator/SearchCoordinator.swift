//
//  SearchCoordinator.swift
//  Search
//
//  Created by Gegi Ghvachliani on 25/06/2026.
//

import UIKit
import SharedCore
import SearchPresentationAPI

public final class SearchCoordinator: SearchCoordinatorProtocol {
    public var childCoordinators: [Coordinator] = []
    public let navigationController: UINavigationController
    private let factory: SearchFactoryProtocol
    private weak var router: SearchRoutingProtocol?
    
    public init(
        navigationController: UINavigationController,
        factory: SearchFactoryProtocol,
        router: SearchRoutingProtocol
    ) {
        self.navigationController = navigationController
        self.factory = factory
        self.router = router
    }
    
    public func start() {
        let searchVC = factory.makeSearchViewController(coordinator: self)
        navigationController.setViewControllers(([searchVC]), animated: false)
    }

    public func showMovieDetails(movie: Movie) {
        router?.showMovieDetails(movie: movie)
    }

    public func showActorDetails(actorID: Int) {
        router?.showActorDetails(actorID: actorID)
    }
}

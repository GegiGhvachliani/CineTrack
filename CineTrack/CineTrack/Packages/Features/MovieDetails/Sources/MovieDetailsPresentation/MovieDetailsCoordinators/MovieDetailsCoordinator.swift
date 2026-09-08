import UIKit

import MovieDetailsPresentationAPI
import SharedCore

public final class MovieDetailsCoordinator: MovieDetailsCoordinatorProtocol {
    public var childCoordinators: [Coordinator] = []

    private let movie: Movie
    private let navigationController: UINavigationController
    private let factory: MovieDetailsFactoryProtocol
    private weak var router: MovieDetailsRoutingProtocol?

    public init(
        movie: Movie,
        navigationController: UINavigationController,
        factory: MovieDetailsFactoryProtocol,
        router: MovieDetailsRoutingProtocol
    ) {
        self.movie = movie
        self.navigationController = navigationController
        self.factory = factory
        self.router = router
    }

    public func start() {
        let viewController = factory.makeMovieDetailsViewController(
            movie: movie,
            onMovieDetails: { [weak self] movie in
                self?.router?.showMovieDetails(movie: movie)
            },
            onActorDetails: { [weak self] actorID in
                self?.router?.showActorDetails(actorID: actorID)
            },
            onNewsDetails: { [weak self] news in
                self?.router?.showNewsDetails(news: news)
            }
        )
        navigationController.pushViewController(viewController, animated: true)
    }
}

//
//  HomeCoordinator.swift
//  Home
//
//  Created by Gegi Ghvachliani on 24/06/2026.
//

import UIKit
import SharedCore
import HomePresentationAPI
import HomeDomain

public final class HomeCoordinator: HomeCoordinatorProtocol {
    
    public var childCoordinators: [Coordinator] = []
    public let navigationController: UINavigationController
    private let factory: HomeFactoryProtocol
    
    private weak var router: HomeRoutingProtocol?
    
    public init(
        navigationController: UINavigationController,
        factory: HomeFactoryProtocol,
        router: HomeRoutingProtocol
        
    ) {
        self.navigationController = navigationController
        self.factory = factory
        self.router = router
    }
    
    public func start() {
        let homeVC = factory.makeHomeViewController(coordinator: self)
        navigationController.setViewControllers(([homeVC]), animated: false)
    }
    
    public func showSearch() {
        router?.showSearch()
    }
    public func showMovieDetails(movie: Movie) {
        router?.showMovieDetails(movie: movie)
    }
    public func showVideos(item: FeaturedItem) {
        router?.showVideosList(
            context: VideoPlaylistContext(
                movie: item.movie,
                selectedVideo: item.video,
                source: .home
            )
        )
    }
    public func showActorDetails(actorID: Int) {
        router?.showActorDetails(actorID: actorID)
    }
    public func showSeeAll(content: SeeAllContent) {
        router?.showSeeAll(content: content)
    }
    public func showNewsDetail(news: News) {
        router?.showNewsDetails(news: news)
    }
}

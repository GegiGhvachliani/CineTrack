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
    
    private let router: HomeRoutingProtocol
    
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
        print("Navigate To Search 🔍")
    }
    public func showMovieDetails(movie: Movie) {
        router.showMovieDetails(movie: movie)
    }
    public func showVideos(item: FeaturedItem) {
        router.showVideosList(item: item)
    }
    public func showActorDetails(actor: SharedCore.Actor) {
        router.showActorDetails(actor: actor)
    }
    public func showSeeAll(section: HomeSection) {
        router.showSeeAll(section: section)
    }
    public func showNewsDetail(news: News) {
        router.showNewsDetails(news: news)
    }
}

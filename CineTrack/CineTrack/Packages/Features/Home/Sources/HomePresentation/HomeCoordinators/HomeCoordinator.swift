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
    
    public init(
        navigationController: UINavigationController,
        factory: HomeFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    public func start() {
        let homeVC = factory.makeHomeViewController(coordinator: self)
        navigationController.setViewControllers(([homeVC]), animated: false)
    }
    
    public func showSearch() {
        print("Navigate To Search 🔍")
    }
    public func showMovieDetails(movie: Movie) {
        print("Navigate To Movie Details 🍿")
    }
    public func showVideos(item: FeaturedItem) {
        print("Navigate To Video Playlist 📀")
    }
    public func showActorDetails(actor: Actor) {
        print("Navigate To Actor Details 💃🏿")
    }
    public func showSeeAll(section: HomeDomain.HomeSection) {
        print("Navigate To Section See All 🔥")
    }
    public func showNewsDetail(news: SharedCore.News) {
        print("Navigate To News Details 🍿")
    }
}

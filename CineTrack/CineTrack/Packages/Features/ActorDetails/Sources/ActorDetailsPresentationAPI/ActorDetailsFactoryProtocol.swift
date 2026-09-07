//
//  ActorDetailsFactoryProtocol.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SharedCore
import ActorDetailsDomain

@MainActor
public protocol ActorDetailsFactoryProtocol {
    
    func makeActorDetailsCoordinator(
        actorID: Int,
        navigationController: UINavigationController,
        router: ActorDetailsRoutingProtocol
    ) -> ActorDetailsCoordinatorProtocol

    func makeActorDetailsViewController(
        actorID: Int,
        onMovieDetails: @escaping (Movie) -> Void,
        onNewsDetails: @escaping (News) -> Void,
        onShowAllPhotos: @escaping ([ActorImage], String) -> Void,
        onShowMiniBiography: @escaping (ActorDetails) -> Void,
        onShowAllFilmography: @escaping () -> Void
    ) -> UIViewController

    func makeActorPhotosViewController(
        images: [ActorImage],
        actorName: String
    ) -> UIViewController

    func makeMiniBiographyViewController(actor: ActorDetails) -> UIViewController
}

@MainActor
public protocol ActorDetailsCoordinatorProtocol: Coordinator { }

@MainActor
public protocol ActorDetailsRoutingProtocol: AnyObject {
    func showMovieDetails(movie: Movie)
    func showNewsDetails(news: News)
    func showSeeAll(section: HomeSection)
}

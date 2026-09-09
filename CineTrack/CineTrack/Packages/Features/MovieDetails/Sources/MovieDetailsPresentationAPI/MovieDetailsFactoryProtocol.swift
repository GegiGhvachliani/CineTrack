//
//  MovieDetailsFactoryProtocol.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SharedCore

@MainActor
public protocol MovieDetailsFactoryProtocol {
    func makeMovieDetailsCoordinator(
        movie: Movie,
        navigationController: UINavigationController,
        router: MovieDetailsRoutingProtocol
    ) -> MovieDetailsCoordinatorProtocol

    func makeMovieDetailsViewController(
        movie: Movie,
        onMovieDetails: @escaping (Movie) -> Void,
        onActorDetails: @escaping (Int) -> Void,
        onNewsDetails: @escaping (News) -> Void,
        onShowSeeAll: @escaping (SeeAllContent) -> Void,
        onShowVideos: @escaping (VideoPlaylistContext) -> Void
    ) -> UIViewController
}

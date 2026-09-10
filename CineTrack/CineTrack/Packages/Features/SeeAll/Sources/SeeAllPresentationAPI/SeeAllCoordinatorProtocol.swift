//
//  SeeAllCoordinatorProtocol.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SharedCore

public protocol SeeAllCoordinatorProtocol: Coordinator {

    var onFinish: (() -> Void)? { get set }

    func showMovieDetails(movie: Movie)
    func showActorDetails(actor: Actor)
    func showNewsDetails(news: News)
    func close()
}

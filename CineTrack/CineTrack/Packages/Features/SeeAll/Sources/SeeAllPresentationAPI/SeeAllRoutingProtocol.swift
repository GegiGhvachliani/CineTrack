//
//  SeeAllFactory.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SharedCore

@MainActor
public protocol SeeAllRoutingProtocol: AnyObject {
    func showMovieDetails(movie: Movie)
    func showActorDetails(actorID: Int)
    func showNewsDetails(news: News)
}

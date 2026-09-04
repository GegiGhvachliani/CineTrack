//
//  HomeRoutingProtocol.swift
//  Home
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SharedCore

@MainActor
public protocol HomeRoutingProtocol: AnyObject {
    func showActorDetails(actor: SharedCore.Actor)
    func showMovieDetails(movie: Movie)
    func showNewsDetails(news: News)
    func showSeeAll(section: HomeSection)
    func showVideosList(item: FeaturedItem)
}


//
//  HomeRoutingProtocol.swift
//  Home
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SharedCore

@MainActor
public protocol HomeRoutingProtocol: AnyObject {
    func showSearch()
    func showActorDetails(actorID: Int)
    func showMovieDetails(movie: Movie)
    func showNewsDetails(news: News)
    func showSeeAll(content: SeeAllContent)
    func showVideosList(context: VideoPlaylistContext)
}

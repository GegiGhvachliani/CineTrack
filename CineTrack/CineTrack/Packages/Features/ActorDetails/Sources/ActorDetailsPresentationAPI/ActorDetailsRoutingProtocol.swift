//
//  ActorDetailsRoutingProtocol.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import UIKit
import SharedCore

@MainActor
public protocol ActorDetailsRoutingProtocol: AnyObject {
    func showMovieDetails(movie: Movie)
    func showNewsDetails(news: News)
    func showSeeAll(content: SeeAllContent)
    func showVideosList(context: VideoPlaylistContext)
}

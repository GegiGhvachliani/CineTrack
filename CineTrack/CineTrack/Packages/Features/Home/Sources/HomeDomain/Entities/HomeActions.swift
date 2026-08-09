//
//  HomeActions.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SharedCore


enum HomeAction {
    case search
    case movieDetails(Movie)
    case actorDetails(Actor)
    case videos(FeaturedItem)
    case watchlist(Movie)
    case favouriteActor(Actor)
}

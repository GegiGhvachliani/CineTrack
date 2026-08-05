//
//  HomeActions.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SharedCore

struct MovieActor {}

enum HomeAction {
    case search
    case movieDetails(Movie)
    case actorDetails(MovieActor)
    case videos(FeaturedItem)
    case watchlist(Movie)
    case favouriteActor(MovieActor)
}

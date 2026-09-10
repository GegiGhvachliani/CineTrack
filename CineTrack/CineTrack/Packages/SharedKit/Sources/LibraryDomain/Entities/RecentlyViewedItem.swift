//
//  RecentlyViewedItem.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import Foundation

public enum RecentlyViewedItem: Identifiable, Sendable, Equatable {

    case movie(RecentlyViewedMovie)
    case actor(RecentlyViewedActor)

    public var id: String {
        switch self {
        case .movie(let movie):
            return "movie-\(movie.id)"

        case .actor(let actor):
            return "actor-\(actor.id)"
        }
    }

    public var viewedAt: Date {
        switch self {
        case .movie(let movie):
            return movie.viewedAt

        case .actor(let actor):
            return actor.viewedAt
        }
    }
}

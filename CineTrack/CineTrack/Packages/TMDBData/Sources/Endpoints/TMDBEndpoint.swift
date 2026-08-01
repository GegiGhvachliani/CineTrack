//
//  TMDBEndpoint.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
import SharedKit

public enum TMDBEndpoint {
    case trending(timeWindow: TrendingTimeWindow)
    case popular
    case topRated
    case nowPlaying
    case upcoming
}

public enum TrendingTimeWindow: String {
    case day
    case week
}

public extension TMDBEndpoint {

    static var defaultTrending: TMDBEndpoint {
        .trending(timeWindow: .week)
    }

    var path: String {
        switch self {
        case .trending(let timeWindow):
            return "/3/trending/movie/\(timeWindow.rawValue)"

        case .popular:
            return "/3/movie/popular"

        case .topRated:
            return "/3/movie/top_rated"

        case .nowPlaying:
            return "/3/movie/now_playing"

        case .upcoming:
            return "/3/movie/upcoming"
        }
    }

    var method: HTTPMethod {
        .get
    }
}

//
//  TMDBEndpoint.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
import SharedNetworking

public enum TMDBEndpoint {
    case trending(
        timeWindow: TrendingTimeWindow,
        page: Int
    )
    case popular(page: Int)
    case topRated(page: Int)
    case nowPlaying(page: Int)
    case upcoming(page: Int)
    case movieVideos(movieID: Int)
}

public enum TrendingTimeWindow: String {
    case day
    case week
}

public extension TMDBEndpoint {

    static var defaultTrending: TMDBEndpoint {
        .trending(timeWindow: .week,page: 1)
    }

    var path: String {
        switch self {
        case .trending(let timeWindow, _):
            return "/3/trending/movie/\(timeWindow.rawValue)"

        case .popular:
            return "/3/movie/popular"

        case .topRated:
            return "/3/movie/top_rated"

        case .nowPlaying:
            return "/3/movie/now_playing"

        case .upcoming:
            return "/3/movie/upcoming"
            
        case .movieVideos(let movieID):
                return "/3/movie/\(movieID)/videos"
            }
        }

    var page: Int? {
        switch self {
        case .trending(_, let page):
            return page

        case .popular(let page):
            return page

        case .topRated(let page):
            return page

        case .nowPlaying(let page):
            return page

        case .upcoming(let page):
            return page
            
        case .movieVideos:
            return nil
        }
    }

    var method: HTTPMethod {
        .get
    }
}

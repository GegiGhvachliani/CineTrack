//
//  TMDBEndpoint.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
import SharedNetworking

public enum TMDBEndpoint {

    // MARK: - Movies

    case trending(timeWindow: TrendingTimeWindow, page: Int)

    case popular(page: Int)

    case topRated(page: Int)

    case discoverMovies(
        page: Int,
        sortBy: String,
        voteCountGreaterThanOrEqual: Int
    )

    case nowPlaying(page: Int)

    case upcoming(page: Int, region: String)

    case movieVideos(movieID: Int)

    // MARK: - People

    case popularPeople(page: Int)

    case personDetails(personID: Int)
    
    case discoverUpcoming(
        page: Int,
        region: String,
        releaseDateGTE: String
    )
    
    case personMovieCredits(personID: Int)
}

public enum TrendingTimeWindow: String {
    case day
    case week
}

extension TMDBEndpoint {

    // MARK: - Default Trending

    public static var defaultTrending: TMDBEndpoint {
        .trending(
            timeWindow: .week,
            page: 1
        )
    }

    // MARK: - Path

    public var path: String {

        switch self {

        case .trending(let timeWindow, _):
            return "/3/trending/movie/\(timeWindow.rawValue)"

        case .popular:
            return "/3/movie/popular"

        case .topRated:
            return "/3/movie/top_rated"

        case .discoverMovies:
            return "/3/discover/movie"

        case .nowPlaying:
            return "/3/movie/now_playing"

        case .upcoming:
            return "/3/movie/upcoming"

        case .movieVideos(let movieID):
            return "/3/movie/\(movieID)/videos"

        case .popularPeople:
            return "/3/person/popular"

        case .personDetails(let personID):
            return "/3/person/\(personID)"
            
        case .discoverUpcoming:
            return "/3/discover/movie"
            
        case .personMovieCredits(let personID):
            return "/3/person/\(personID)/movie_credits"
        }
    }

    // MARK: - Page

    public var page: Int? {

        switch self {

        case .trending(_, let page):
            return page

        case .popular(let page):
            return page

        case .topRated(let page):
            return page

        case .discoverMovies(let page, _, _):
            return page

        case .nowPlaying(let page):
            return page

        case .upcoming(let page, _):
            return page

        case .movieVideos:
            return nil

        case .popularPeople(let page):
            return page

        case .personDetails:
            return nil
            
        case .discoverUpcoming(let page, _, _):
            return page
            
        case .personMovieCredits:
            return nil
            
        }
    }

    // MARK: - Method

    public var method: HTTPMethod {
        .get
    }
}

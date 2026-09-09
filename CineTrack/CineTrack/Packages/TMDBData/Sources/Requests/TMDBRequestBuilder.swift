//
//  TMDBRequestBuilder.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
import SharedNetworking

public struct TMDBRequestBuilder: Sendable {

    private let configuration: TMDBConfiguration

    public init(configuration: TMDBConfiguration) {
        self.configuration = configuration
    }

    public func build(for endpoint: TMDBEndpoint) throws -> APIRequest {

        var components = URLComponents(
            url: configuration.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        )

        var queryItems: [URLQueryItem] = []

        // MARK: - Page

        if let page = endpoint.page {

            queryItems.append(URLQueryItem(name: "page",value: String(page)))
            
        }

        // MARK: - Text search

        switch endpoint {
        case .searchMovies(let query, _), .searchPeople(let query, _), .searchKeywords(let query, _):
            queryItems.append(URLQueryItem(name: "query", value: query))
            queryItems.append(URLQueryItem(name: "include_adult", value: "false"))
        default:
            break
        }

        // MARK: - Discover Movies

        if case let .discoverMovies(
            _,
            sortBy,
            voteCountGreaterThanOrEqual
        ) = endpoint {

            queryItems.append(
                URLQueryItem(
                    name: "sort_by",
                    value: sortBy
                )
            )

            queryItems.append(
                URLQueryItem(
                    name: "vote_count.gte",
                    value:
                        String(
                            voteCountGreaterThanOrEqual
                        )
                )
            )
        }

        // MARK: - Advanced Movie Search

        if case let .advancedMovieSearch(
            _,
            minimumRating,
            minimumVoteCount,
            genreIDs,
            minimumReleaseYear,
            maximumReleaseYear,
            minimumRuntime,
            maximumRuntime,
            originCountryCodes,
            keywordIDs
        ) = endpoint {

            queryItems.append(URLQueryItem(name: "sort_by", value: "popularity.desc"))

            if let minimumRating {
                queryItems.append(URLQueryItem(name: "vote_average.gte", value: String(minimumRating)))
            }

            if let minimumVoteCount {
                queryItems.append(URLQueryItem(name: "vote_count.gte", value: String(minimumVoteCount)))
            }

            if let minimumReleaseYear {
                queryItems.append(
                    URLQueryItem(
                        name: "primary_release_date.gte",
                        value: "\(minimumReleaseYear)-01-01"
                    )
                )
            }

            if let maximumReleaseYear {
                queryItems.append(
                    URLQueryItem(
                        name: "primary_release_date.lte",
                        value: "\(maximumReleaseYear)-12-31"
                    )
                )
            }

            if let minimumRuntime {
                queryItems.append(URLQueryItem(name: "with_runtime.gte", value: String(minimumRuntime)))
            }

            if let maximumRuntime {
                queryItems.append(URLQueryItem(name: "with_runtime.lte", value: String(maximumRuntime)))
            }

            if !genreIDs.isEmpty {
                queryItems.append(
                    URLQueryItem(
                        name: "with_genres",
                        value: genreIDs.map(String.init).joined(separator: ",")
                    )
                )
            }

            if !keywordIDs.isEmpty {
                queryItems.append(URLQueryItem(name: "with_keywords", value: keywordIDs.map(String.init).joined(separator: "|")))
            }

            if !originCountryCodes.isEmpty {
                queryItems.append(
                    URLQueryItem(
                        name: "with_origin_country",
                        value: originCountryCodes.joined(separator: "|")
                    )
                )
            }
        }
        
        // MARK: - Chronological Upcoming Movies

        if case let .discoverUpcoming(_, _, releaseDateGTE) = endpoint {
            queryItems.append(
                URLQueryItem(
                    name: "sort_by",
                    value: "primary_release_date.asc"
                )
            )

            queryItems.append(
                URLQueryItem(
                    name: "primary_release_date.gte",
                    value: releaseDateGTE
                )
            )
        }

        // MARK: - Upcoming Region

        if case let .upcoming(
            _,
            region
        ) = endpoint {

            queryItems.append(
                URLQueryItem(
                    name: "region",
                    value: region
                )
            )
        }

        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }

        return APIRequest(
            url: url,
            method: endpoint.method,
            headers: [
                "Authorization":
                    "Bearer \(configuration.accessToken)",

                "Accept":
                    "application/json"
            ]
        )
    }

}

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

    public init(
        configuration: TMDBConfiguration
    ) {
        self.configuration = configuration
    }

    public func build(
        for endpoint: TMDBEndpoint
    ) throws -> APIRequest {

        var components = URLComponents(
            url:
                configuration.baseURL
                .appendingPathComponent(
                    endpoint.path
                ),
            resolvingAgainstBaseURL: false
        )

        var queryItems: [URLQueryItem] = []

        // MARK: - Page

        if let page = endpoint.page {

            queryItems.append(
                URLQueryItem(
                    name: "page",
                    value: String(page)
                )
            )
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

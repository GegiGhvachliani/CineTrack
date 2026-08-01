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

    public func build(for endpoint: TMDBEndpoint) -> APIRequest {
        var components = URLComponents(
            url: configuration.baseURL
                .appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        )

        components?.queryItems = [
            URLQueryItem(
                name: "page",
                value: String(endpoint.page)
            )
        ]

        guard let url = components?.url else {
            fatalError("Failed to build URL for endpoint: \(endpoint)")
        }

        return APIRequest(
            url: url,
            method: endpoint.method,
            headers: [
                "Authorization": "Bearer \(configuration.accessToken)",
                "Accept": "application/json"
            ]
        )
    }
}

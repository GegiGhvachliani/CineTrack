//
//  NewsRequestBuilder.swift
//  NewsData
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//


import Foundation
import SharedNetworking

public struct NewsRequestBuilder: Sendable {

    private let configuration: NewsConfiguration

    public init(
        configuration: NewsConfiguration
    ) {
        self.configuration = configuration
    }

    public func build(
        for endpoint: NewsEndpoint
    ) throws -> APIRequest {

        var components = URLComponents(
            url: configuration.baseURL,
            resolvingAgainstBaseURL: false
        )

        components?.path = endpoint.path
        components?.queryItems = endpoint.queryItems

        guard let url = components?.url else {
            throw URLError(.badURL)
        }

        return APIRequest(
            url: url,
            method: endpoint.method,
            headers: [
                "X-Api-Key": configuration.apiKey,
                "Accept": "application/json"
            ]
        )
    }
}

//
//  TMDBRequestBuilder.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
import SharedKit

public struct TMDBRequestBuilder {

    private let configuration: TMDBConfiguration

    public init(configuration: TMDBConfiguration) {
        self.configuration = configuration
    }

    public func build(for endpoint: TMDBEndpoint) -> APIRequest {
        let url = configuration.baseURL.appendingPathComponent(endpoint.path)

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

//
//  APIRequest.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation

public struct APIRequest {

    public let url: URL
    public let method: HTTPMethod
    public let headers: [String: String]
    public let body: Data?

    public init(
        url: URL,
        method: HTTPMethod = .get,
        headers: [String: String] = [:],
        body: Data? = nil
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }

    public func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue
        request.httpBody = body

        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}

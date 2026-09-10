//
//  NewsConfiguration.swift
//  NewsData
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

public struct NewsConfiguration: Sendable {

    // MARK: - Properties

    public let baseURL: URL
    public let apiKey: String

    // MARK: - Initialization

    public init(
        baseURL: URL,
        apiKey: String
    ) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
}

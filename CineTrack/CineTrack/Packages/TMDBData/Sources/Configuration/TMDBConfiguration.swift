//
//  TMDBConfiguration.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation

public struct TMDBConfiguration {

    public let baseURL: URL
    public let accessToken: String

    public init(
        baseURL: URL,
        accessToken: String
    ) {
        self.baseURL = baseURL
        self.accessToken = accessToken
    }
}

//
//  NewsEndpoint.swift
//  NewsData
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation
import SharedNetworking

public enum NewsEndpoint: Sendable {

    case entertainment(
        page: Int,
        pageSize: Int
    )

    case person(
        name: String,
        page: Int,
        pageSize: Int
    )

    public var path: String {
        "/v2/everything"
    }

    public var method: HTTPMethod {
        .get
    }

    public var queryItems: [URLQueryItem] {

        switch self {

        case .entertainment(let page, let pageSize):

            return [
                URLQueryItem(
                    name: "q",
                    value: "(movie OR film OR actor OR actress OR cinema OR Hollywood)"
                ),
                URLQueryItem(
                    name: "language",
                    value: "en"
                ),
                URLQueryItem(
                    name: "sortBy",
                    value: "publishedAt"
                ),
                URLQueryItem(
                    name: "page",
                    value: String(page)
                ),
                URLQueryItem(
                    name: "pageSize",
                    value: String(pageSize)
                )
            ]

        case .person(let name, let page, let pageSize):
            return [
                URLQueryItem(name: "q", value: "\(name) AND (movie OR film OR actor OR actress OR cinema)"),
                URLQueryItem(name: "language", value: "en"),
                URLQueryItem(name: "sortBy", value: "publishedAt"),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "pageSize", value: String(pageSize))
            ]
        }
    }
}

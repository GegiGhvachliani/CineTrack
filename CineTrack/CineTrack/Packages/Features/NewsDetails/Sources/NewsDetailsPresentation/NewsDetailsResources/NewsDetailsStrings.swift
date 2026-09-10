//
//  NewsDetailsStrings.swift
//  NewsDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

enum NewsDetailsStrings {

    // MARK: - Article

    enum Article {
        static let title = "News"
        static let source = "the source"
        static let noDescription = "No description is available for this article."

        static func metadata(date: String, source: String) -> String {
            "\(date) · \(source)"
        }

        static func readMore(source: String) -> String {
            "See full article on \(source)"
        }
    }
}

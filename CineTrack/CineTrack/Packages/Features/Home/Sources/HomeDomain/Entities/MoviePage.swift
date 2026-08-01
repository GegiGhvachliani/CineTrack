//
//  MoviePage.swift
//  HomeDomain
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

import Foundation
import SharedCore

public struct MoviePage {

    public let movies: [Movie]
    public let page: Int
    public let totalPages: Int

    public var hasNextPage: Bool {
        page < totalPages
    }

    public init(
        movies: [Movie],
        page: Int,
        totalPages: Int
    ) {
        self.movies = movies
        self.page = page
        self.totalPages = totalPages
    }
}

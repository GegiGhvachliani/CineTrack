//
//  ActorCredit.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public struct ActorCredit: Identifiable, Equatable, Sendable {

    // MARK: - Identity

    public let id: Int
    public let creditID: String?

    // MARK: - Movie

    public let title: String
    public let overview: String

    /// TMDB-ის raw path-ები. საჭიროა MovieDetails-ისთვის.
    public let posterPath: String?
    public let backdropPath: String?

    /// UI-ისთვის მზა URL-ები.
    public let posterURL: URL?
    public let backdropURL: URL?

    public let releaseDate: String?
    public let voteAverage: Double
    public let voteCount: Int

    // MARK: - Role

    public let character: String?
    public let department: String?
    public let job: String?
    public let order: Int?

    // MARK: - Initialization

    public init(
        id: Int,
        creditID: String?,
        title: String,
        overview: String,
        posterPath: String?,
        backdropPath: String?,
        posterURL: URL?,
        backdropURL: URL?,
        releaseDate: String?,
        voteAverage: Double,
        voteCount: Int,
        character: String?,
        department: String?,
        job: String?,
        order: Int?
    ) {
        self.id = id
        self.creditID = creditID
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.posterURL = posterURL
        self.backdropURL = backdropURL
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.character = character
        self.department = department
        self.job = job
        self.order = order
    }
}

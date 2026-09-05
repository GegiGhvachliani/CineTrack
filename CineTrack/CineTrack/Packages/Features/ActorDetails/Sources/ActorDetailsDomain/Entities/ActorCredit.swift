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
    public let posterPath: String?
    public let backdropPath: String?
    public let releaseDate: String?

    // MARK: - Role

    public let character: String?
    public let order: Int?

    // MARK: - Init

    public init(
        id: Int,
        creditID: String?,
        title: String,
        posterPath: String?,
        backdropPath: String?,
        releaseDate: String?,
        character: String?,
        order: Int?
    ) {
        self.id = id
        self.creditID = creditID
        self.title = title
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.character = character
        self.order = order
    }
}

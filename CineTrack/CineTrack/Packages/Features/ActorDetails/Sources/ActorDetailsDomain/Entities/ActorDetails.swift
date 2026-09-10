//
//  ActorDetails.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public struct ActorDetails: Identifiable, Equatable, Sendable {

    // MARK: - Identity

    public let id: Int
    public let name: String

    // MARK: - Personal Information

    public let birthday: Date?
    public let deathday: Date?
    public let placeOfBirth: String?

    // MARK: - Career

    public let knownForDepartment: String?
    public let biography: String?

    // MARK: - Images

    public let profilePath: String?
    public let profileURL: URL?

    // MARK: - External

    public let homepage: String?
    public let imdbID: String?

    // MARK: - Additional

    public let alsoKnownAs: [String]

    // MARK: - Initialization

    public init(
        id: Int,
        name: String,
        birthday: Date?,
        deathday: Date?,
        placeOfBirth: String?,
        knownForDepartment: String?,
        biography: String?,
        profilePath: String?,
        profileURL: URL?,
        homepage: String?,
        imdbID: String?,
        alsoKnownAs: [String]
    ) {
        self.id = id
        self.name = name
        self.birthday = birthday
        self.deathday = deathday
        self.placeOfBirth = placeOfBirth
        self.knownForDepartment = knownForDepartment
        self.biography = biography
        self.profilePath = profilePath
        self.profileURL = profileURL
        self.homepage = homepage
        self.imdbID = imdbID
        self.alsoKnownAs = alsoKnownAs
    }
}

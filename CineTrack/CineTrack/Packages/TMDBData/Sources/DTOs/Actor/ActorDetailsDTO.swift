//
//  ActorDetailsDTO.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation

public struct ActorDetailsDTO: Decodable, Sendable {

    public let id: Int
    public let name: String
    public let birthday: String?
    public let deathday: String?
    public let gender: Int?
    public let biography: String
    public let placeOfBirth: String?
    public let popularity: Double
    public let knownForDepartment: String?
    public let profilePath: String?
    public let homepage: String?
    public let imdbID: String?
    public let alsoKnownAs: [String]

    public init(
        id: Int,
        name: String,
        birthday: String?,
        deathday: String?,
        gender: Int?,
        biography: String,
        placeOfBirth: String?,
        popularity: Double,
        knownForDepartment: String?,
        profilePath: String?,
        homepage: String?,
        imdbID: String?,
        alsoKnownAs: [String]
    ) {
        self.id = id
        self.name = name
        self.birthday = birthday
        self.deathday = deathday
        self.gender = gender
        self.biography = biography
        self.placeOfBirth = placeOfBirth
        self.popularity = popularity
        self.knownForDepartment = knownForDepartment
        self.profilePath = profilePath
        self.homepage = homepage
        self.imdbID = imdbID
        self.alsoKnownAs = alsoKnownAs
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case birthday
        case deathday
        case gender
        case biography
        case placeOfBirth = "place_of_birth"
        case popularity
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
        case homepage
        case imdbID = "imdb_id"
        case alsoKnownAs = "also_known_as"
    }
}

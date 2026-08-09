//
//  PersonDTO.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//


import Foundation

public struct PersonDTO: Decodable, Sendable {

    public let id: Int
    public let name: String
    public let birthday: String?
    public let profilePath: String?

    public init(
        id: Int,
        name: String,
        birthday: String?,
        profilePath: String?
    ) {
        self.id = id
        self.name = name
        self.birthday = birthday
        self.profilePath = profilePath
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case birthday
        case profilePath = "profile_path"
    }
}
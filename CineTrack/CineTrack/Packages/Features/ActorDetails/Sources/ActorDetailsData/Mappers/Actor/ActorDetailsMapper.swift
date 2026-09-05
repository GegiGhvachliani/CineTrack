//
//  ActorDetailsMapper.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation
import TMDBData
import ActorDetailsDomain

public struct ActorDetailsMapper: Sendable {

    public init() {}

    public func map(
        _ dto: ActorDetailsDTO
    ) -> ActorDetails {
        ActorDetails(
            id: dto.id,
            name: dto.name,
            birthday: Self.parseDate(dto.birthday),
            deathday: Self.parseDate(dto.deathday),
            placeOfBirth: dto.placeOfBirth,
            knownForDepartment: dto.knownForDepartment,
            biography: dto.biography,
            profilePath: dto.profilePath,
            homepage: dto.homepage,
            imdbID: dto.imdbID,
            alsoKnownAs: dto.alsoKnownAs
        )
    }

    private static func parseDate(
        _ value: String?
    ) -> Date? {
        guard let value else {
            return nil
        }

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.date(from: value)
    }
}

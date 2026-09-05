//
//  PersonMapper.swift
//  TMDBData
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation
import SharedCore

public struct PersonMapper: Sendable {

    public init() {}

    public func map(_ dto: PersonDTO) -> Actor? {

        guard dto.knownForDepartment == "Acting" else {
            return nil
        }

        return Actor(
            id: dto.id,
            name: dto.name,
            birthday: parseBirthday(dto.birthday),
            profilePath: makeImageURL(dto.profilePath)
        )
    }

    private func parseBirthday(_ value: String?) -> Date? {
        guard let value else {
            return nil
        }

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.date(from: value)
    }

    private func makeImageURL(_ path: String?) -> String? {
        guard let path else {
            return nil
        }

        return "https://image.tmdb.org/t/p/w500\(path)"
    }
}

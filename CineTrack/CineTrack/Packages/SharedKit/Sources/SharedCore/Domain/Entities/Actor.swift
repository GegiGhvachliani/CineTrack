//
//  Actor.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

public struct Actor: Identifiable, Sendable, Equatable {

    // MARK: - Properties

    public let id: Int
    public let name: String
    public let birthday: Date?
    public let profilePath: String?

    // MARK: - Initialization

    public init(
        id: Int,
        name: String,
        birthday: Date?,
        profilePath: String?
    ) {
        self.id = id
        self.name = name
        self.birthday = birthday
        self.profilePath = profilePath
    }

    public var age: Int? {
        guard let birthday else {
            return nil
        }

        return Calendar.current.dateComponents(
            [.year],
            from: birthday,
            to: Date()
        ).year
    }
}

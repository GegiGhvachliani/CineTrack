//
//  RecentlyViewedActor.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//


import Foundation
import SharedCore

public struct RecentlyViewedActor: Identifiable, Sendable, Equatable {

    public let id: Int
    public let name: String
    public let birthday: Date?
    public let profilePath: String?
    public let viewedAt: Date

    public init(
        id: Int,
        name: String,
        birthday: Date?,
        profilePath: String?,
        viewedAt: Date
    ) {
        self.id = id
        self.name = name
        self.birthday = birthday
        self.profilePath = profilePath
        self.viewedAt = viewedAt
    }
}
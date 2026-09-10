//
//  User.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import Foundation

public struct User: Sendable {

    // MARK: - Properties

    public let id: String
    public let email: String
    public let username: String

    // MARK: - Initialization

    public init(
        id: String,
        email: String,
        username: String
    ) {
        self.id = id
        self.email = email
        self.username = username
    }
}

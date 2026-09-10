//
//  ProfilePhotoProcessorProtocol.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import Foundation

public struct ProfileAccount: Sendable {

    // MARK: - Properties

    public let email: String
    public let createdAt: Date?
    public let photoURL: URL?
    public var photoData: Data?

    // MARK: - Initialization

    public init(email: String, createdAt: Date?, photoURL: URL?, photoData: Data? = nil) {
        self.email = email
        self.createdAt = createdAt
        self.photoURL = photoURL
        self.photoData = photoData
    }
}

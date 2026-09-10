//
//  ProfilePhotoProcessorProtocol.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import Foundation

public protocol ProfilePhotoProcessorProtocol: Sendable {
    func prepare(_ data: Data) throws -> Data
}

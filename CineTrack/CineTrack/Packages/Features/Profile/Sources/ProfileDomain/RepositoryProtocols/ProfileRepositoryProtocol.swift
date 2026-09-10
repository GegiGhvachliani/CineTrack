//
//  ProfilePhotoProcessorProtocol.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import Foundation

public protocol ProfileRepositoryProtocol: Sendable {
    func fetchAccount() async throws -> ProfileAccount
    func updatePhoto(_ data: Data) async throws -> Data
    func signOut() async throws
}

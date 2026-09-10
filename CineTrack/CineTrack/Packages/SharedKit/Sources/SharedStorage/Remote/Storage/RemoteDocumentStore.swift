//
//  RemoteDocumentStore.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

public protocol RemoteDocumentStore: Sendable {

    func set<T: Encodable & Sendable>(
        _ value: T,
        collection: String,
        documentID: String
    ) async throws

    func get<T: Decodable & Sendable>(
        _ type: T.Type,
        collection: String,
        documentID: String
    ) async throws -> T?

    func delete(
        collection: String,
        documentID: String
    ) async throws

    func getCollection<T: Decodable & Sendable>(
        _ type: T.Type,
        collection: String
    ) async throws -> [T]
}

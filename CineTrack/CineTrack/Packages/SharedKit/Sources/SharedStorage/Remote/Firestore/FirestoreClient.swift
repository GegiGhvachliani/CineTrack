//
//  FirestoreClient.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation
import FirebaseFirestore

public final class FirestoreClient:
    RemoteDocumentStore,
    @unchecked Sendable {

    private let db: Firestore

    public init(
        db: Firestore = Firestore.firestore()
    ) {
        self.db = db
    }

    public func set<T: Encodable & Sendable>(
        _ value: T,
        collection: String,
        documentID: String
    ) async throws {

        try await db
            .collection(collection)
            .document(documentID)
            .setData(
                from: value,
                merge: true
            )
    }

    public func get<T: Decodable & Sendable>(
        _ type: T.Type,
        collection: String,
        documentID: String
    ) async throws -> T? {

        let snapshot =
            try await db
                .collection(collection)
                .document(documentID)
                .getDocument()

        guard snapshot.exists else {
            return nil
        }

        return try snapshot.data(
            as: T.self
        )
    }

    public func delete(
        collection: String,
        documentID: String
    ) async throws {

        try await db
            .collection(collection)
            .document(documentID)
            .delete()
    }

    public func getCollection<T: Decodable & Sendable>(
        _ type: T.Type,
        collection: String
    ) async throws -> [T] {

        let snapshot =
            try await db
                .collection(collection)
                .getDocuments()

        return try snapshot.documents.map {
            try $0.data(as: T.self)
        }
    }
}

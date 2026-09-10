//
//  FirebaseUserSession.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation
import FirebaseAuth

public final class FirebaseUserSession:
    AccountSession,
    @unchecked Sendable {

    // MARK: - Initialization

    public init() {}

    public var currentUserID: String? {
        Auth.auth().currentUser?.uid
    }
    public var currentAccount: AccountSessionUser? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }

        return AccountSessionUser(
            id: user.uid,
            email: user.email,
            createdAt: user.metadata.creationDate,
            photoURL: user.photoURL
        )
    }

    public func signOut() throws {
        try Auth.auth().signOut()
    }
}

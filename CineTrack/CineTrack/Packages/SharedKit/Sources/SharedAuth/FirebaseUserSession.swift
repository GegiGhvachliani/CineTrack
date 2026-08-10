//
//  FirebaseUserSession.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//


import Foundation
import FirebaseAuth

public final class FirebaseUserSession:
    UserSession,
    @unchecked Sendable {

    public init() {}

    public var currentUserID: String? {
        Auth.auth().currentUser?.uid
    }
}
//
//  FirestoreError.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

public enum FirestoreError: Error, Sendable {

    case unauthenticated
    case documentNotFound
    case invalidData
}

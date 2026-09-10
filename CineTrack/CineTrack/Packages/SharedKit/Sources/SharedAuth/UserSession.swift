//
//  UserSession.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

public protocol UserSession: Sendable {

    var currentUserID: String? { get }
}

//
//  AuthenticationCoordinatorProtocol.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import SharedCore

public protocol AuthenticationCoordinatorProtocol: Coordinator {
    var onFinish: (() -> Void)? { get set }
}

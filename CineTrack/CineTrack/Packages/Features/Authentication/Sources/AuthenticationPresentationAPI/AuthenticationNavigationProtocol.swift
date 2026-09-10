//
//  AuthenticationNavigationProtocol.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 31/07/2026.
//
import Foundation

@MainActor
public protocol AuthenticationNavigationProtocol: AnyObject {
    var onFinish: (() -> Void)? { get set }
    func showSignUp()
    func navigateBack()
}

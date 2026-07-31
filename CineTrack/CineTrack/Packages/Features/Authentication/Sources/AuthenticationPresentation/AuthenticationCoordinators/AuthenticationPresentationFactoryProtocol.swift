//
//  AuthenticationPresentationFactoryProtocol.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 31/07/2026.
//

import UIKit
import AuthenticationPresentationAPI

@MainActor
public protocol AuthenticationPresentationFactoryProtocol {
    func makeSignInViewController(coordinator: AuthenticationNavigationProtocol) -> UIViewController
    func makeSignUpViewController(coordinator: AuthenticationNavigationProtocol) -> UIViewController
}

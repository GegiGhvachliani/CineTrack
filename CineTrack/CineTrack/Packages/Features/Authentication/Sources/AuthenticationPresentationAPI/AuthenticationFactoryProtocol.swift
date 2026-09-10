//
//  AuthenticationFactoryProtocol.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import UIKit

@MainActor
public protocol AuthenticationFactoryProtocol {
    func makeAuthenticationCoordinator(navigationController: UINavigationController)
        -> AuthenticationCoordinatorProtocol

    func isUserAuthenticated() -> Bool

    func makeSignInViewController(coordinator: AuthenticationNavigationProtocol) -> UIViewController
    func makeSignUpViewController(coordinator: AuthenticationNavigationProtocol) -> UIViewController
}

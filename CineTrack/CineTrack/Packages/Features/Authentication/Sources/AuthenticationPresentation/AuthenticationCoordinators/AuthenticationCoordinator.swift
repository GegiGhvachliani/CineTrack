//
//  AuthenticationCoordinator.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import UIKit
import SharedCore
import AuthenticationPresentationAPI

public final class AuthenticationCoordinator: AuthenticationCoordinatorProtocol, AuthenticationNavigationProtocol {

    // MARK: - Properties

    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    public var onFinish: (() -> Void)?

    private let factory: AuthenticationFactoryProtocol

    // MARK: - Initialization

    public init(
        navigationController: UINavigationController,
        factory: AuthenticationFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.factory = factory
    }

    public func start() {
        let viewController = factory.makeSignInViewController(coordinator: self)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.setViewControllers([viewController], animated: false)
    }

    public func showSignIn() {
        let viewController = factory.makeSignInViewController(coordinator: self)

        if navigationController.viewControllers.isEmpty {
            navigationController.setViewControllers([viewController], animated: true)
        } else {
            navigationController.pushViewController(viewController, animated: true)
        }
    }

    public func showSignUp() {
        let viewController = factory.makeSignUpViewController(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }

    public func navigateBack() {
        navigationController.popViewController(animated: true)
    }
}

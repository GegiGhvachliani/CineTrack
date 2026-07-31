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
    
    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    public var onFinish: (() -> Void)?
    
    private let factory: AuthenticationPresentationFactoryProtocol

    public init(
        navigationController: UINavigationController,
        factory: AuthenticationPresentationFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    public func start() {
        showSignIn()
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

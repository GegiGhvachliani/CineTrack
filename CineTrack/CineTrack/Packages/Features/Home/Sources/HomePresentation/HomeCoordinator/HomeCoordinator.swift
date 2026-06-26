//
//  HomeCoordinator.swift
//  Home
//
//  Created by Gegi Ghvachliani on 24/06/2026.
//

import UIKit
import SharedCore
import HomePresentationAPI

public final class HomeCoordinator: HomeCoordinatorProtocol {
    public var childCoordinators: [Coordinator] = []
    public let navigationController: UINavigationController
    private let factory: HomeFactoryProtocol
    
    public init(
        navigationController: UINavigationController,
        factory: HomeFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    public func start() {
        let homeVC = factory.makeHomeViewController()
        navigationController.setViewControllers(([homeVC]), animated: false)
    }
}

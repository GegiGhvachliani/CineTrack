//
//  ProfileCoordinator.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 25/06/2026.
//

import UIKit
import SharedCore
import ProfilePresentationAPI

public final class ProfileCoordinator: ProfileCoordinatorProtocol {
    public var childCoordinators: [Coordinator] = []
    public let navigationController: UINavigationController
    private let factory: ProfileFactoryProtocol
    
    public init(
        navigationController: UINavigationController,
        factory: ProfileFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    public func start() {
        let profileVC = factory.makeProfileViewController()
        navigationController.setViewControllers(([profileVC]), animated: false)
    }
}

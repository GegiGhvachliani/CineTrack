//
//  ProfileCoordinator.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 25/06/2026.
//

import ProfilePresentationAPI
import SharedCore
import UIKit

public final class ProfileCoordinator: ProfileCoordinatorProtocol {
    public var childCoordinators: [Coordinator] = []
    public let navigationController: UINavigationController
    private let factory: ProfileFactoryProtocol
    private weak var router: ProfileRoutingProtocol?

    public init(
        navigationController: UINavigationController,
        factory: ProfileFactoryProtocol,
        router: ProfileRoutingProtocol
    ) {
        self.navigationController = navigationController
        self.factory = factory
        self.router = router
    }

    public func start() {
        guard let router else { return }
        let profileVC = factory.makeProfileViewController(router: router)
        navigationController.setViewControllers(([profileVC]), animated: false)
    }
}

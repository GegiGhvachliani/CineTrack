//
//  SearchCoordinator.swift
//  Search
//
//  Created by Gegi Ghvachliani on 25/06/2026.
//

import UIKit
import SharedCore
import SearchPresentationAPI

public final class SearchCoordinator: SearchCoordinatorProtocol {
    public var childCoordinators: [Coordinator] = []
    public let navigationController: UINavigationController
    private let factory: SearchFactoryProtocol
    
    public init(
        navigationController: UINavigationController,
        factory: SearchFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    public func start() {
        let searchVC = factory.makeSearchViewController()
        navigationController.setViewControllers(([searchVC]), animated: false)
    }
}

//
//  HomeFactoryProtocol.swift
//  Home
//
//  Created by Gegi Ghvachliani on 24/06/2026.
//

import UIKit

@MainActor
public protocol HomeFactoryProtocol {

    func makeHomeViewController(coordinator: HomeCoordinatorProtocol) -> UIViewController

    func makeHomeCoordinator(navigationController: UINavigationController, router: HomeRoutingProtocol)
        -> HomeCoordinatorProtocol
}

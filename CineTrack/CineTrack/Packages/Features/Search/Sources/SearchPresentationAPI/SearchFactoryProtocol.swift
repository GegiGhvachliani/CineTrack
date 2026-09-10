//
//  SearchFactoryProtocol.swift
//  Search
//
//  Created by Gegi Ghvachliani on 25/06/2026.
//

import UIKit

@MainActor
public protocol SearchFactoryProtocol {
    func makeSearchViewController(coordinator: SearchCoordinatorProtocol) -> UIViewController
    func makeSearchCoordinator(
        navigationController: UINavigationController,
        router: SearchRoutingProtocol
    ) -> SearchCoordinatorProtocol
}

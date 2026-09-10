//
//  SeeAllFactoryProtocol.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SharedCore

@MainActor
public protocol SeeAllFactoryProtocol {

    func makeSeeAllCoordinator(
        content: SeeAllContent,
        presentingController: UIViewController,
        router: SeeAllRoutingProtocol
    ) -> SeeAllCoordinatorProtocol

    func makeSeeAllViewController(
        content: SeeAllContent,
        coordinator: SeeAllCoordinatorProtocol
    ) -> UIViewController
}

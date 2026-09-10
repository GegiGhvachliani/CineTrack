//
//  ProfileFactoryProtocol.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 24/06/2026.
//

import SharedCore
import UIKit

@MainActor
public protocol ProfileFactoryProtocol {
    func makeProfileViewController(router: ProfileRoutingProtocol) -> UIViewController
    func makeProfileCoordinator(navigationController: UINavigationController, router: ProfileRoutingProtocol)
        -> ProfileCoordinatorProtocol

}

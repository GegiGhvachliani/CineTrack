//
//  ProfileFactoryProtocol.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 24/06/2026.
//

import UIKit

@MainActor
public protocol ProfileFactoryProtocol {
    func makeProfileViewController() -> UIViewController
    func makeProfileCoordinator(navigationController: UINavigationController) -> ProfileCoordinatorProtocol

}

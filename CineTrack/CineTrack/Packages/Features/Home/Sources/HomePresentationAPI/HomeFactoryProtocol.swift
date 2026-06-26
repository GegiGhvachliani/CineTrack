//
//  HomeFactoryProtocol.swift
//  Home
//
//  Created by Gegi Ghvachliani on 24/06/2026.
//

import UIKit

@MainActor
public protocol HomeFactoryProtocol { //TODO: დასამატებელი გაქვს
    func makeHomeViewController() -> UIViewController
    func makeHomeCoordinator(navigationController: UINavigationController) -> HomeCoordinatorProtocol
}

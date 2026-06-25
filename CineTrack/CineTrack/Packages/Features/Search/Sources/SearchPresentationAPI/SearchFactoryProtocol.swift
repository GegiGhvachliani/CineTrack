//
//  SearchFactoryProtocol.swift
//  Search
//
//  Created by Gegi Ghvachliani on 25/06/2026.
//

import UIKit

@MainActor
public protocol SearchFactoryProtocol { //TODO: დასამატებელი გაქვს
    func makeSearchViewController() -> UIViewController
    func makeSearchCoordinator(navigationController: UINavigationController) -> SearchCoordinatorProtocol
}

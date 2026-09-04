//
//  SeeAllRepositoryProtocol.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SharedCore

@MainActor
public protocol SeeAllFactoryProtocol {

    func makeSeeAllViewController(section: HomeSection) -> UIViewController
}

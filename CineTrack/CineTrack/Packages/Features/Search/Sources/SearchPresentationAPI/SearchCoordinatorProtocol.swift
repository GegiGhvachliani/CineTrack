//
//  SearchCoordinatorProtocol.swift
//  Search
//
//  Created by Gegi Ghvachliani on 24/06/2026.
//

import UIKit
import SharedCore

@MainActor
public protocol SearchCoordinatorProtocol: Coordinator {
    var navigationController: UINavigationController { get }
}

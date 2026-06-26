//
//  HomeCoordinatorProtocol.swift
//  Home
//
//  Created by Gegi Ghvachliani on 24/06/2026.
//

import UIKit
import SharedCore

public protocol HomeCoordinatorProtocol: Coordinator {
    var navigationController: UINavigationController { get }
}

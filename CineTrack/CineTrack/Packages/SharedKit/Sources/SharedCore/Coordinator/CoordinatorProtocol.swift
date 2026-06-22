//
//  CoordinatorProtocol.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 06/06/2026.
//

public protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    func start()
}

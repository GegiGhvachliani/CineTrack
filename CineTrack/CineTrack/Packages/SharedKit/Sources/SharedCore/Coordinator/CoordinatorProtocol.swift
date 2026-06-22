//
//  CoordinatorProtocol.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 06/06/2026.
//

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

public extension Coordinator {
    func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        print(" [Coordinator] Added child: \(type(of: coordinator))")
    }
    
    func removeChild(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
        print(" [Coordinator] Removed child: \(type(of: coordinator))")
    }
    
    func removeAllChildren() {
        childCoordinators.removeAll()
        print(" [Coordinator] Removed all children")
    }
}

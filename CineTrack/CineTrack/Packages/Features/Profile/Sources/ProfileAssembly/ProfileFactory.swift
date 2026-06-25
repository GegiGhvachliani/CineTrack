//
//  ProfileFactory.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import UIKit
import ProfilePresentation
import ProfilePresentationAPI

public struct ProfileFactory: ProfileFactoryProtocol {
    
    public init() {}
    
    public func makeProfileViewController() -> UIViewController {
        let vc = UIViewController()
        
        vc.view.backgroundColor = .systemPurple
        
        let label = UILabel()
        label.text = "Profile Page"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        vc.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor)
        ])
        
        return vc
    }
    
    public func makeProfileCoordinator(navigationController: UINavigationController) -> ProfileCoordinatorProtocol {
        return ProfileCoordinator(navigationController: navigationController, factory: self)
    }
}

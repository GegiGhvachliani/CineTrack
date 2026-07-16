//
//  HomeFactory.swift
//  Home
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import UIKit
import FirebaseAuth
import HomePresentation
import HomePresentationAPI

public struct HomeFactory: HomeFactoryProtocol {
    
    public init() {}
    
    public func makeHomeViewController() -> UIViewController {
        let vc = UIViewController()
        
        vc.view.backgroundColor = .systemYellow
        
        // MARK: - Label
        let label = UILabel()
        label.text = "Home Page"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        vc.view.addSubview(label)
        
        // MARK: - Sign Out Button
        let signOutAction = UIAction { _ in
            do {
                try Auth.auth().signOut()
                print("✅ დროებითი Sign Out შესრულდა წარმატებით.")
            } catch let error {
                print("❌ Sign Out ერორი: \(error.localizedDescription)")
            }
        }
        
        let signOutButton = UIButton(type: .system, primaryAction: signOutAction)
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.backgroundColor = .systemRed
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.layer.cornerRadius = 8
        signOutButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        vc.view.addSubview(signOutButton)
        
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            // Label Constraints
            label.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor, constant: -30),
            
            // Button Constraints
            signOutButton.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            signOutButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            signOutButton.widthAnchor.constraint(equalToConstant: 120),
            signOutButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        return vc
    }
    
    public func makeHomeCoordinator(navigationController: UINavigationController) -> HomeCoordinatorProtocol {
        return HomeCoordinator(navigationController: navigationController, factory: self)
    }
}

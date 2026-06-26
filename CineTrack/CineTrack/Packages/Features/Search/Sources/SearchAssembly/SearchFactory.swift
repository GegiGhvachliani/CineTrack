//
//  SearchFactory.swift
//  Search
//
//  Created by Gegi Ghvachliani on 25/06/2026.
//

import UIKit
import SearchPresentation
import SearchPresentationAPI

public struct SearchFactory: SearchFactoryProtocol {
    
    public init() {}
    
    public func makeSearchViewController() -> UIViewController {
        let vc = UIViewController()
        
        vc.view.backgroundColor = .systemGreen
        
        let label = UILabel()
        label.text = "Search Page"
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
    
    public func makeSearchCoordinator(navigationController: UINavigationController) -> SearchCoordinatorProtocol {
        return SearchCoordinator(navigationController: navigationController, factory: self)
    }
}

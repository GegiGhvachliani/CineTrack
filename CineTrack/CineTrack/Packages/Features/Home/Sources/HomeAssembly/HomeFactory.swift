//
//  HomeFactory.swift
//  Home
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import UIKit
import HomeDomain
import HomeData
import HomePresentation
import SharedCore

@MainActor
public protocol HomeFactoryProtocol {
    func makeHomeViewController() -> UIViewController
}

public struct HomeFactory: HomeFactoryProtocol {
    
    public init() {}
    
    public func makeHomeViewController() -> UIViewController {
        let vc = UIViewController()
        
        vc.view.backgroundColor = .systemYellow
        
        let label = UILabel()
        label.text = "Home Page"
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
}

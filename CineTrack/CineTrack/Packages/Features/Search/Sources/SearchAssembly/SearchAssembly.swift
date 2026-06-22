//
//  SearchAssembly.swift
//  Search
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import UIKit
import SearchDomain
import SearchData
import SearchPresentation
import SharedCore

@MainActor
public protocol SearchFactoryProtocol {
    func makeSearchViewController() -> UIViewController
}

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
}

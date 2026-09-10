//
//  MainTabBarController.swift
//  CineTrack
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import UIKit
import SwiftUI
import DesignSystemTokens

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBarAppearance()
    }

    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()

        appearance.backgroundColor = UIColor(ColorTokens.Background.primary).withAlphaComponent(0.95)
        appearance.shadowColor = .clear

        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(ColorTokens.Text.secondary)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(ColorTokens.Text.secondary)
        ]

        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(ColorTokens.Brand.primary)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(ColorTokens.Brand.primary)
        ]

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance

        tabBar.tintColor = UIColor(ColorTokens.Brand.primary)
        tabBar.isTranslucent = true
    }
}

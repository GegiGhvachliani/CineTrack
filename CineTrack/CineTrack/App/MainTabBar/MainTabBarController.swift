//
//  MainTabBarController.swift
//  CineTrack
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBarAppearance()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        configureTabBarFrame()
    }

    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()

        appearance.configureWithDefaultBackground()

        appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.75)
        appearance.shadowColor = .clear

        appearance.stackedLayoutAppearance.normal.iconColor = .secondaryLabel
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.secondaryLabel
        ]

        appearance.stackedLayoutAppearance.selected.iconColor = .systemBlue
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.systemBlue
        ]

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance

        tabBar.isTranslucent = true
        tabBar.tintColor = .systemBlue

        tabBar.layer.cornerRadius = 24
        tabBar.layer.masksToBounds = true
    }

    private func configureTabBarFrame() {
        let horizontalInset: CGFloat = 16
        let bottomInset: CGFloat = 12

        let height: CGFloat = 64

        tabBar.frame = CGRect(
            x: horizontalInset,
            y: view.bounds.height - height - bottomInset,
            width: view.bounds.width - (horizontalInset * 2),
            height: height
        )
    }
}

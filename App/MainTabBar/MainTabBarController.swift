//
//  MainTabBarController.swift
//  CineTrack
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import HomeAssembly
import ProfileAssembly
import SearchAssembly
import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarAppearance()
    }

    private func configureTabBarAppearance() {
        tabBar.tintColor = .systemBlue  // აქტიური ტაბის ფერი
        tabBar.backgroundColor = .systemBackground  // ტაბბარის უკანა ფონი
    }
}

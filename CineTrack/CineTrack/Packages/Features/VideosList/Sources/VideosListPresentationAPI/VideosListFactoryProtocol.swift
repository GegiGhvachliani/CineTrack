//
//  VideosListFactoryProtocol.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import UIKit
import SharedCore

@MainActor
public protocol VideosListFactoryProtocol {

    func makeVideosListCoordinator(
        context: VideoPlaylistContext,
        navigationController: UINavigationController,
        router: VideosListRoutingProtocol
    ) -> VideosListCoordinatorProtocol

    func makeVideosListViewController(
        context: VideoPlaylistContext,
        coordinator: VideosListCoordinatorProtocol
    ) -> UIViewController
}

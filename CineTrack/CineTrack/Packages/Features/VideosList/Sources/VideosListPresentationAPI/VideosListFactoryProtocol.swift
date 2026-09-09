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
    func makeVideosListViewController(
        context: VideoPlaylistContext,
        onMovieDetails: @escaping (VideoPlaylistContext) -> Void
    ) -> UIViewController
}

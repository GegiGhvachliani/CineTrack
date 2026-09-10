//
//  VideosListCoordinatorProtocol.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import Foundation
import SharedCore

public protocol VideosListCoordinatorProtocol: Coordinator {
    func showMovieDetails(context: VideoPlaylistContext)
    func close()
}

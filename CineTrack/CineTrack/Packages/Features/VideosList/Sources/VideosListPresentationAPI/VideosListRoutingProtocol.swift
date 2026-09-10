//
//  VideosListRoutingProtocol.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SharedCore

@MainActor
public protocol VideosListRoutingProtocol: AnyObject {
    func showMovieDetails(from context: VideoPlaylistContext)
}

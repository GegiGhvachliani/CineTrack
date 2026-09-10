//
//  VideosListViewModelProtocol.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import Foundation
import Observation
import SharedCore
import VideosListDomain

@MainActor
public protocol VideosListViewModelProtocol: AnyObject, Observable {

    // MARK: - State & Actions

    var movie: Movie { get }
    var context: VideoPlaylistContext { get }
    var selectedVideo: MovieVideo { get }
    var playlist: [MovieVideo] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var onMovieDetails: ((VideoPlaylistContext) -> Void)? { get set }
    var canSelectPreviousVideo: Bool { get }
    var canSelectNextVideo: Bool { get }

    func close()

    // MARK: - Methods

    func loadPlaylist() async
    func selectVideo(_ video: MovieVideo)
    func selectPreviousVideo()
    func selectNextVideo()
    func showMovieDetails()
}

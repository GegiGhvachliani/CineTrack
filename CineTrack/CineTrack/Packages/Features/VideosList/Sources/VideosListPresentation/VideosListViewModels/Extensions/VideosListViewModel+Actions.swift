//
//  VideosListViewModel.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import Foundation
import Observation
import SharedCore
import VideosListDomain

extension VideosListViewModel {

    // MARK: - Actions

    public func close() {
        onClose?()
    }

    public func selectVideo(_ video: MovieVideo) {
        selectedVideo = video
    }

    public func selectPreviousVideo() {
        guard let index = selectedVideoIndex, index > 0 else {
            return
        }

        selectedVideo = playlist[index - 1]
    }

    public func selectNextVideo() {
        guard let index = selectedVideoIndex, index < playlist.count - 1 else {
            return
        }

        selectedVideo = playlist[index + 1]
    }

    public func showMovieDetails() {
        onMovieDetails?(context)
    }
}

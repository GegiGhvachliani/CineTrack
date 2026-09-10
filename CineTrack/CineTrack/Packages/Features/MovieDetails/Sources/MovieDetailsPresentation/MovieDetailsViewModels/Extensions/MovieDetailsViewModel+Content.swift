//
//  MovieDetailsViewModel+Content.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import Foundation
import LibraryDomain
import Observation
import MovieDetailsDomain
import SharedCore

extension MovieDetailsViewModel {

    // MARK: - Content

    public func isWatchlisted(_ movie: Movie) -> Bool {
        watchlistedMovieIDs.contains(movie.id)
    }

    internal func videoSortOrder(_ left: MovieVideo, _ right: MovieVideo) -> Bool {
        videoPriority(left) < videoPriority(right)
    }

    private func videoPriority(_ video: MovieVideo) -> Int {
        switch (video.official, video.type) {
        case (true, .trailer):
            return 0
        case (_, .trailer):
            return 1
        case (_, .teaser):
            return 2
        case (_, .featurette):
            return 3
        case (_, .behindTheScenes):
            return 4
        case (_, .clip):
            return 5
        case (_, .bloopers):
            return 6
        case (_, .unknown):
            return 7
        }
    }
}

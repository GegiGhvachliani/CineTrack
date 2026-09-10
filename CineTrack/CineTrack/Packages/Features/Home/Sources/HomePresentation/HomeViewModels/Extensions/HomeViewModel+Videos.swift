//
//  HomeViewModel+Videos.swift
//  Home
//
//  Created by Gegi Ghvachliani on 13/08/2026.
//

import Foundation

import HomeDomain
import SharedCore

extension HomeViewModel {

    // MARK: - Videos

    public func loadVideos(
        for movie: Movie
    ) async {

        error = nil

        do {

            let videos = try await fetchMovieVideosUseCase.execute(movieID: movie.id)
            movieVideos[movie.id] = videos

        } catch {

            print("❌ Videos Error:", error)
            self.error = error

        }
    }
}

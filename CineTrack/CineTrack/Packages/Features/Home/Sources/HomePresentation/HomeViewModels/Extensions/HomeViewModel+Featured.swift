//
//  HomeViewModel+Featured.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import Foundation

import HomeDomain
import SharedCore

extension HomeViewModel {

    // MARK: - Featured

    internal func loadFeaturedItems() async {

        let movies = Array(nowPlayingMovies.prefix(5))

        guard !movies.isEmpty else {
            featuredItems = []
            return
        }

        let items = await withTaskGroup(of: (Int, FeaturedItem?).self) { group in

            for (index, movie) in movies.enumerated() {

                group.addTask { [fetchMovieVideosUseCase] in

                    do {

                        let videos = try await fetchMovieVideosUseCase.execute(movieID: movie.id)

                        guard let video = await self.selectFeaturedVideo(from: videos)

                        else {
                            return (index, nil)
                        }

                        let item = FeaturedItem(movie: movie, video: video)

                        return (index, item)

                    } catch {

                        return (index, nil)
                    }
                }
            }

            var results: [(Int, FeaturedItem)] = []

            for await (index, item) in group {

                if let item {
                    results.append((index, item))
                }
            }

            return results.sorted { $0.0 < $1.0 }.map(\.1)
        }

        featuredItems = items
    }

    // MARK: - Video Selection

    internal func selectFeaturedVideo(from videos: [MovieVideo]) -> MovieVideo? {

        let priority: [VideoType] = [
            .trailer,
            .behindTheScenes,
            .featurette,
            .bloopers
        ]

        for type in priority {

            if let officialVideo =
                videos.first(
                    where: {
                        $0.type == type && $0.site == .youtube && $0.official
                    }
                ) {
                return officialVideo
            }

            if let video =
                videos.first(
                    where: {
                        $0.type == type && $0.site == .youtube
                    }
                ) {
                return video
            }
        }

        return nil
    }
}

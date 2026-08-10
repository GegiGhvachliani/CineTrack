//
//  HomeViewModel+RecentlyViewed.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import Foundation

import HomeDomain
import SharedCore

extension HomeViewModel {

    // MARK: - Load

    public func loadRecentlyViewed() async {

        guard !isRecentlyViewedLoading else {
            return
        }

        isRecentlyViewedLoading = true

        defer {
            isRecentlyViewedLoading = false
        }

        do {

            async let movies =
                fetchRecentlyViewedMoviesUseCase.execute()

            async let actors =
                fetchRecentlyViewedActorsUseCase.execute()

            recentlyViewedMovies =
                try await movies

            recentlyViewedActors =
                try await actors

        } catch {

            print(
                "❌ Recently Viewed Error:",
                error
            )

            self.error = error
        }
    }

    // MARK: - Add Movie

    public func addRecentlyViewed(
        movie: Movie
    ) async {

        let recentlyViewedMovie =
            RecentlyViewedMovie(
                id: movie.id,
                title: movie.title,
                posterPath: movie.posterPath,
                releaseDate: movie.releaseDate,
                voteAverage: movie.voteAverage,
                viewedAt: Date()
            )

        do {

            try await addRecentlyViewedMovieUseCase
                .execute(
                    recentlyViewedMovie
                )

            recentlyViewedMovies.removeAll {
                $0.id == movie.id
            }

            recentlyViewedMovies.insert(
                recentlyViewedMovie,
                at: 0
            )

        } catch {

            print(
                "❌ Add Recently Viewed Movie Error:",
                error
            )

            self.error = error
        }
    }

    // MARK: - Add Actor

    public func addRecentlyViewed(
        actor: Actor
    ) async {

        let recentlyViewedActor =
            RecentlyViewedActor(
                id: actor.id,
                name: actor.name,
                birthday: actor.birthday,
                profilePath: actor.profilePath,
                viewedAt: Date()
            )

        do {

            try await addRecentlyViewedActorUseCase
                .execute(
                    recentlyViewedActor
                )

            recentlyViewedActors.removeAll {
                $0.id == actor.id
            }

            recentlyViewedActors.insert(
                recentlyViewedActor,
                at: 0
            )

        } catch {

            print(
                "❌ Add Recently Viewed Actor Error:",
                error
            )

            self.error = error
        }
    }
}

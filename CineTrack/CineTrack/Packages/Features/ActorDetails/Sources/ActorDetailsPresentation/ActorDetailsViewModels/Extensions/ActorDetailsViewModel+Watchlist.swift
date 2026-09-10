//
//  ActorDetailsViewModel.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import ActorDetailsDomain
import LibraryDomain
import SharedCore

extension ActorDetailsViewModel {
    public func isWatchlisted(_ credit: ActorCredit) -> Bool {
        watchlistedMovieIDs.contains(credit.id)
    }

    public func toggleWatchlist(for credit: ActorCredit) async {
        guard pendingWatchlistIDs.insert(credit.id).inserted else {
            return
        }

        defer {
            pendingWatchlistIDs.remove(credit.id)
        }

        let movie = Movie(
            id: credit.id,
            title: credit.title,
            overview: credit.overview,
            posterPath: credit.posterPath,
            backdropPath: credit.backdropPath,
            releaseDate: credit.releaseDate,
            voteAverage: credit.voteAverage,
            voteCount: credit.voteCount
        )
        let wasWatchlisted = watchlistedMovieIDs.contains(movie.id)

        if wasWatchlisted {
            watchlistedMovieIDs.remove(movie.id)
        } else {
            watchlistedMovieIDs.insert(movie.id)
        }

        do {
            if wasWatchlisted {
                try await removeWatchlistedMovieUseCase.execute(movie: movie)
            } else {
                try await addWatchlistedMovieUseCase.execute(movie: movie)
            }
        } catch {
            if wasWatchlisted {
                watchlistedMovieIDs.insert(movie.id)
            } else {
                watchlistedMovieIDs.remove(movie.id)
            }
            sectionErrors[.filmography] = error
        }
    }

    func loadWatchlist() async {
        do {
            watchlistedMovieIDs = Set(
                try await fetchWatchlistedMoviesUseCase.execute().map(\.id)
            )
        } catch {
            sectionErrors[.filmography] = error
        }
    }
}

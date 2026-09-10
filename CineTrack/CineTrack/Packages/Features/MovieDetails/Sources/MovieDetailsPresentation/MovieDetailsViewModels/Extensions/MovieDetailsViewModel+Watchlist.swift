//
//  MovieDetailsViewModel+Watchlist.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SharedCore
import LibraryDomain

extension MovieDetailsViewModel {

    // MARK: - Watchlist

    public func toggleWatchlist() async {
        await toggleWatchlist(for: movie)
    }

    public func toggleWatchlist(for movie: Movie) async {
        guard !pendingWatchlistIDs.contains(movie.id) else {
            return
        }

        pendingWatchlistIDs.insert(movie.id)

        defer {
            pendingWatchlistIDs.remove(movie.id)
        }

        let wasWatchlisted = isWatchlisted(movie)

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

            sectionErrors[.watchlist] = error
        }
    }

    func loadWatchlist() async {
        do {
            watchlistedMovieIDs = Set(
                try await fetchWatchlistedMoviesUseCase.execute().map(\.id)
            )
        } catch {
            sectionErrors[.watchlist] = error
        }
    }
}

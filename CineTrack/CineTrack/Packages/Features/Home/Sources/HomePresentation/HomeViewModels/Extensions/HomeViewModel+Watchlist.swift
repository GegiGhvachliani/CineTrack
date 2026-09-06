//
//  HomeViewModel+Watchlist.swift
//  Home
//
//  Created by Gegi Ghvachliani on 13/08/2026.
//


import Foundation

import HomeDomain
import SharedCore

extension HomeViewModel {

    // MARK: - Load

    public func loadWatchlist() async {

        do {

            watchlistedMovies = try await fetchWatchlistedMoviesUseCase.execute()

        } catch {

            print("❌ Watchlist Load Error:", error)
            self.error = error
            
        }
    }

    // MARK: - Toggle

    public func toggleWatchlist(for movie: Movie) async {
        
        guard pendingWatchlistIDs.insert(movie.id).inserted else {
            return
        }

        defer {
            pendingWatchlistIDs.remove(movie.id)
        }


        let wasWatchlisted = watchlistedMovies.contains { $0.id == movie.id }

        if wasWatchlisted {
            
            watchlistedMovies.removeAll { $0.id == movie.id }

        } else {

            watchlistedMovies.append(movie)
        }

        do {

            if wasWatchlisted {

                try await removeWatchlistedMovieUseCase.execute(movie: movie)

            } else {

                try await addWatchlistedMovieUseCase.execute(movie: movie)
            }

        } catch {

            if wasWatchlisted {

                watchlistedMovies.append(movie)

            } else {

                watchlistedMovies.removeAll { $0.id == movie.id }
            }

            print("❌ Watchlist Toggle Error:", error)
            self.error = error
            
        }
    }
}

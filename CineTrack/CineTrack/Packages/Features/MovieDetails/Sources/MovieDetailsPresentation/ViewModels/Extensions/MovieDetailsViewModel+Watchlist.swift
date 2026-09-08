import SharedCore

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
                try await removeWatchlistedMovieUseCase.execute(movie)
            } else {
                try await addWatchlistedMovieUseCase.execute(movie)
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

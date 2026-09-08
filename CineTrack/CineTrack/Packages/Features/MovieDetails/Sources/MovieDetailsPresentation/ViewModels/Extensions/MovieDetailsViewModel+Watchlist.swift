import SharedCore

extension MovieDetailsViewModel {

    // MARK: - Watchlist

    public func toggleWatchlist() async {
        guard !isWatchlistUpdating else {
            return
        }

        isWatchlistUpdating = true

        defer {
            isWatchlistUpdating = false
        }

        let wasWatchlisted = isWatchlisted

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

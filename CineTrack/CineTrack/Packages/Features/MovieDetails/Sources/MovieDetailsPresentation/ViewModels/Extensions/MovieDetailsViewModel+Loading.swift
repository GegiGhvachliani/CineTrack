import MovieDetailsDomain
import SharedCore

extension MovieDetailsViewModel {

    // MARK: - Initial loading

    public func load() async {
        await load(force: false)
    }

    public func retry() async {
        await load(force: true)
    }

    private func load(force: Bool) async {
        guard !isLoading, force || !hasLoadedInitialContent else {
            return
        }

        isLoading = true
        error = nil
        sectionErrors = [:]

        defer {
            isLoading = false
        }

        do {
            movieDetails = try await fetchMovieDetailsUseCase.execute(movieID: movie.id)
        } catch {
            self.error = error
            return
        }

        hasLoadedInitialContent = true

        async let castTask: Void = loadCastAndRelatedActorMovies()
        async let videosTask: Void = loadVideos()
        async let imagesTask: Void = loadImages()
        async let similarMoviesTask: Void = loadSimilarMovies()
        async let newsTask: Void = loadNews()
        async let watchlistTask: Void = loadWatchlist()

        await castTask
        await videosTask
        await imagesTask
        await similarMoviesTask
        await newsTask
        await watchlistTask
    }

    // MARK: - Sections

    private func loadCastAndRelatedActorMovies() async {
        await loadCast()

        guard let selectedActor else {
            return
        }

        await loadMovies(for: selectedActor)
    }

    private func loadCast() async {
        isCastLoading = true

        defer {
            isCastLoading = false
        }

        do {
            cast = try await fetchMovieCastUseCase.execute(movieID: movie.id)
            selectedActor = cast.first
        } catch {
            sectionErrors[.cast] = error
        }
    }

    private func loadVideos() async {
        isVideosLoading = true

        defer {
            isVideosLoading = false
        }

        do {
            videos = try await fetchMovieVideosUseCase.execute(movieID: movie.id)
        } catch {
            sectionErrors[.videos] = error
        }
    }

    private func loadImages() async {
        isImagesLoading = true

        defer {
            isImagesLoading = false
        }

        do {
            images = try await fetchMovieImagesUseCase.execute(movieID: movie.id)
        } catch {
            sectionErrors[.images] = error
        }
    }

    private func loadSimilarMovies() async {
        isSimilarMoviesLoading = true

        defer {
            isSimilarMoviesLoading = false
        }

        do {
            similarMovies = try await fetchSimilarMoviesUseCase.execute(
                movieID: movie.id,
                page: 1
            )
        } catch {
            sectionErrors[.similarMovies] = error
        }
    }

    private func loadMovies(for actor: MovieCastMember) async {
        isRelatedActorLoading = true

        defer {
            isRelatedActorLoading = false
        }

        do {
            selectedActorMovies = try await fetchActorMoviesUseCase.execute(actorID: actor.id)
                .filter { $0.id != movie.id }
        } catch {
            sectionErrors[.relatedActor] = error
        }
    }

    private func loadNews() async {
        isNewsLoading = true

        defer {
            isNewsLoading = false
        }

        do {
            news = try await fetchMovieNewsUseCase.execute(movieTitle: movie.title)
        } catch {
            sectionErrors[.news] = error
        }
    }
}

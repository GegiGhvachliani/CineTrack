//
//  ActorDetailsViewModel+Loading.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 07/09/2026.
//

import ActorDetailsDomain

extension ActorDetailsViewModel {

    // MARK: - Initial loading

    public func load() async {
        if hasLoadedInitialContent {
            async let favourites: Void = loadFavourites()
            async let watchlist: Void = loadWatchlist()
            await favourites
            await watchlist
            return
        }
        await load(force: false)
    }

    public func retry() async {
        await load(force: true)
    }

    private func load(force: Bool) async {
        guard !isLoading else {
            return
        }

        guard force || !hasLoadedInitialContent else {
            return
        }

        isLoading = true
        error = nil
        sectionErrors = [:]

        defer {
            isLoading = false
        }

        do {
            actor = try await fetchActorDetailsUseCase.execute(
                actorID: actorID
            )
        } catch {
            self.error = error
            return
        }

        guard let actor else {
            return
        }

        onActorViewed?(actor)

        if force {
            resetSectionContent()
        }

        hasLoadedInitialContent = true

        async let creditsTask: Void = loadCreditsAndVideos()
        async let mediaTask: Void = loadNextMediaPage(actorName: actor.name)
        async let linksTask: Void = loadExternalLinks()
        async let newsTask: Void = loadNews(actorName: actor.name)
        async let favouritesTask: Void = loadFavourites()
        async let watchlistTask: Void = loadWatchlist()

        await creditsTask
        await mediaTask
        await linksTask
        await newsTask
        await favouritesTask
        await watchlistTask
    }

    private func resetSectionContent() {
        credits = []
        mediaImages = []
        actorVideos = []
        externalLinks = nil
        news = []
        mediaContinuation = nil
        hasMoreMedia = true
    }

    // MARK: - Section loading

    private func loadFavourites() async {
        do {
            favouritedActorIDs = Set(
                try await fetchFavouritedActorsUseCase.execute().map(\.id)
            )
        } catch {
            sectionErrors[.favourites] = error
        }
    }

    private func loadCredits() async {
        isCreditsLoading = true

        defer {
            isCreditsLoading = false
        }

        do {
            credits = try await fetchActorCreditsUseCase.execute(
                actorID: actorID
            )
        } catch {
            sectionErrors[.filmography] = error
        }
    }

    private func loadCreditsAndVideos() async {
        await loadCredits()
        await loadVideos(for: filmography)
    }

    private func loadVideos(for credits: [ActorCredit]) async {
        guard !credits.isEmpty else {
            return
        }

        isVideosLoading = true

        defer {
            isVideosLoading = false
        }

        do {
            actorVideos = try await fetchActorVideosUseCase.execute(
                movieIDs: Array(credits.prefix(10).map(\.id))
            )
        } catch {
            sectionErrors[.videos] = error
        }
    }

    public func loadNextMediaPage() async {
        guard let actor else {
            return
        }

        await loadNextMediaPage(actorName: actor.name)
    }

    private func loadNextMediaPage(actorName: String) async {
        guard !isMediaLoading, hasMoreMedia else {
            return
        }

        isMediaLoading = true

        defer {
            isMediaLoading = false
        }

        do {
            let page = try await fetchActorMediaUseCase.execute(
                actorName: actorName,
                continuation: mediaContinuation
            )

            mediaImages.append(contentsOf: page.images)
            mediaContinuation = page.nextToken
            hasMoreMedia = page.nextToken != nil
        } catch {
            sectionErrors[.photos] = error
        }
    }

    private func loadExternalLinks() async {
        isExternalLinksLoading = true

        defer {
            isExternalLinksLoading = false
        }

        do {
            externalLinks = try await fetchActorExternalLinksUseCase.execute(
                actorID: actorID
            )
        } catch {
            sectionErrors[.personalDetails] = error
        }
    }

    private func loadNews(actorName: String) async {
        isNewsLoading = true

        defer {
            isNewsLoading = false
        }

        do {
            news = try await fetchActorNewsUseCase.execute(
                actorName: actorName
            )
        } catch {
            sectionErrors[.news] = error
        }
    }
}

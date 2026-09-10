//
//  HomeViewModel+Actions.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import Foundation
import LibraryDomain

import HomeDomain
import SharedCore

extension HomeViewModel {

    public func didTapSearch() {
        onSearch?()
    }

    public func didTapMovie(_ movie: Movie) {
        onMovieDetails?(movie)
    }

    public func didTapActor(_ actor: Actor) {
        onActorDetails?(actor.id)
    }

    public func didTapVideos(_ item: FeaturedItem) {
        onVideos?(item)
    }

    public func didTapSeeAll(_ section: HomeSection) {
        onSeeAll?(seeAllContent(for: section))
    }

    public func didTapNews(_ news: News) {
        onNewsDetails?(news)
    }

    private func seeAllContent(for section: HomeSection) -> SeeAllContent {
        switch section {
        case .bornToday:
            pagedContent(
                title: HomeStrings.Section.bornToday, payload: .actors(bornTodayActors),
                hasMore: { self.hasMoreBornTodayActors }
            ) { [weak self] in
                await self?.loadNextBornTodayActorsPage()
                return self.map { .actors($0.bornTodayActors) }
            }
        case .top10:
            SeeAllContent(title: HomeStrings.Content.top10Title, payload: .movies(top10Movies))
        case .fanFavourites:
            pagedContent(
                title: HomeStrings.Section.fanFavourites, payload: .movies(fanFavouriteMovies),
                hasMore: { self.hasMoreFanFavourite }
            ) { [weak self] in
                await self?.loadNextFanFavouritePage()
                return self.map { .movies($0.fanFavouriteMovies) }
            }
        case .nowPlaying:
            pagedContent(
                title: HomeStrings.Content.nowStreaming, payload: .movies(nowPlayingMovies),
                hasMore: { self.hasMoreNowPlaying }
            ) { [weak self] in
                await self?.loadNextNowPlayingPage()
                return self.map { .movies($0.nowPlayingMovies) }
            }
        case .upcoming:
            pagedContent(
                title: HomeStrings.Content.comingSoon, payload: .movies(upcomingMovies),
                hasMore: { self.hasMoreUpcoming }
            ) { [weak self] in
                await self?.loadNextUpcomingPage()
                return self.map { .movies($0.upcomingMovies) }
            }
        case .fromYourWatchlist, .watchlist:
            SeeAllContent(title: HomeStrings.Content.fromYourWatchlist, payload: .movies(watchlistedMovies))
        case .trending:
            pagedContent(
                title: HomeStrings.Content.trendingNow, payload: .movies(trendingMovies),
                hasMore: { self.hasMoreTrending }
            ) { [weak self] in
                await self?.loadNextTrendingPage()
                return self.map { .movies($0.trendingMovies) }
            }
        case .popularActors, .mostPopularCelebrities:
            pagedContent(
                title: HomeStrings.Section.mostPopularCelebrities, payload: .actors(mostPopularActors),
                hasMore: { self.hasMoreMostPopularCelebrities }
            ) { [weak self] in
                await self?.loadNextMostPopularCelebritiesPage()
                return self.map { .actors($0.mostPopularActors) }
            }
        case .moreFromActor:
            SeeAllContent(
                title: HomeStrings.Format.moreFrom(
                    actorName: selectedFavouriteActor?.name ?? HomeStrings.Content.actor),
                payload: .movies(selectedFavouriteActorMovies))
        case .favouritePeople:
            SeeAllContent(title: HomeStrings.Content.yourFavouritePeople, payload: .actors(favouritedActors))
        case .news:
            pagedContent(title: HomeStrings.Content.topNews, payload: .news(news), hasMore: { self.hasMoreNews }) {
                [weak self] in
                await self?.loadNextNewsPage()
                return self.map { .news($0.news) }
            }
        case .recentlyViewed:
            recentlyViewedContent()
        case .header, .filmography:
            SeeAllContent(title: HomeStrings.Content.movies, payload: .movies([]))
        }
    }

    private func recentlyViewedContent() -> SeeAllContent {
        let items = recentlyViewedItems.map { item -> SeeAllLibraryItem in
            switch item {
            case .movie(let movie):
                return .movie(
                    Movie(
                        id: movie.id,
                        title: movie.title,
                        overview: "",
                        posterPath: movie.posterPath,
                        backdropPath: nil,
                        releaseDate: movie.releaseDate,
                        voteAverage: movie.voteAverage,
                        voteCount: 0
                    )
                )
            case .actor(let actor):
                return .actor(
                    Actor(
                        id: actor.id,
                        name: actor.name,
                        birthday: actor.birthday,
                        profilePath: actor.profilePath
                    )
                )
            }
        }
        return SeeAllContent(title: HomeStrings.Section.recentlyViewed, payload: .library(items))
    }

    private func pagedContent(
        title: String, payload: SeeAllPayload, hasMore: @escaping () -> Bool,
        loadMore: @escaping () async -> SeeAllPayload?
    ) -> SeeAllContent {
        SeeAllContent(title: title, payload: payload, hasMore: hasMore, loadMore: loadMore)
    }
}

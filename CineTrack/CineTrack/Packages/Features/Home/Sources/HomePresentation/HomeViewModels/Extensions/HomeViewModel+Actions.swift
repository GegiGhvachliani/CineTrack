//
//  HomeViewModel+Actions.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import Foundation

import HomeDomain
import SharedCore

extension HomeViewModel {

    public func didTapSearch() {
        onSearch?()
    }

    public func didTapMovie(_ movie: Movie) {
        onMovieDetails?(movie)

        Task {
            await addRecentlyViewed(movie: movie)
        }
    }

    public func didTapActor(_ actor: Actor) {
        onActorDetails?(actor.id)

        Task {
            await addRecentlyViewed(actor: actor)
        }
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
            pagedContent(title: "Born Today", payload: .actors(bornTodayActors), hasMore: { self.hasMoreBornTodayActors }) { [weak self] in
                await self?.loadNextBornTodayActorsPage()
                return self.map { .actors($0.bornTodayActors) }
            }
        case .top10:
            SeeAllContent(title: "Top 10", payload: .movies(top10Movies))
        case .fanFavourites:
            pagedContent(title: "Fan Favourites", payload: .movies(fanFavouriteMovies), hasMore: { self.hasMoreFanFavourite }) { [weak self] in await self?.loadNextFanFavouritePage(); return self.map { .movies($0.fanFavouriteMovies) } }
        case .nowPlaying:
            pagedContent(title: "Now Streaming", payload: .movies(nowPlayingMovies), hasMore: { self.hasMoreNowPlaying }) { [weak self] in await self?.loadNextNowPlayingPage(); return self.map { .movies($0.nowPlayingMovies) } }
        case .upcoming:
            pagedContent(title: "Coming Soon", payload: .movies(upcomingMovies), hasMore: { self.hasMoreUpcoming }) { [weak self] in await self?.loadNextUpcomingPage(); return self.map { .movies($0.upcomingMovies) } }
        case .fromYourWatchlist, .watchlist:
            SeeAllContent(title: "From Your Watchlist", payload: .movies(watchlistedMovies))
        case .trending:
            pagedContent(title: "Trending Now", payload: .movies(trendingMovies), hasMore: { self.hasMoreTrending }) { [weak self] in await self?.loadNextTrendingPage(); return self.map { .movies($0.trendingMovies) } }
        case .popularActors, .mostPopularCelebrities:
            pagedContent(title: "Most Popular Celebrities", payload: .actors(mostPopularActors), hasMore: { self.hasMoreMostPopularCelebrities }) { [weak self] in await self?.loadNextMostPopularCelebritiesPage(); return self.map { .actors($0.mostPopularActors) } }
        case .moreFromActor:
            SeeAllContent(title: "More From \(selectedFavouriteActor?.name ?? "Actor")", payload: .movies(selectedFavouriteActorMovies))
        case .favouritePeople:
            SeeAllContent(title: "Your Favourite People", payload: .actors(favouritedActors))
        case .news:
            pagedContent(title: "Top News", payload: .news(news), hasMore: { self.hasMoreNews }) { [weak self] in await self?.loadNextNewsPage(); return self.map { .news($0.news) } }
        case .recentlyViewed:
            SeeAllContent(title: "Recently Viewed", payload: .movies(recentlyViewedMovies.map { movie in
                Movie(id: movie.id, title: movie.title, overview: "", posterPath: movie.posterPath, backdropPath: nil, releaseDate: movie.releaseDate, voteAverage: movie.voteAverage, voteCount: 0)
            }))
        case .header, .filmography:
            SeeAllContent(title: "Movies", payload: .movies([]))
        }
    }

    private func pagedContent(title: String, payload: SeeAllPayload, hasMore: @escaping () -> Bool, loadMore: @escaping () async -> SeeAllPayload?) -> SeeAllContent {
        SeeAllContent(title: title, payload: payload, hasMore: hasMore, loadMore: loadMore)
    }
}

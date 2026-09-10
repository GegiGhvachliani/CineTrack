//
//  HomeStrings.swift
//  Home
//
//  Created by Gegi Ghvachliani on 01/08/2026.
//

public enum HomeStrings {

    // MARK: - Sections

    public enum Section {
        public static let search = "Search for shows, movies, people..."
        public static let trending = "Trending"
        public static let popular = "Popular"
        public static let fanFavourites = "Fan Favourites"
        public static let top10 = "Top 10 on CineTrack this week"
        public static let nowPlaying = "Now Playing"
        public static let upcoming = "Upcoming"
        public static let bornToday = "Born Today"
        public static let watchlist = "From your Watchlist"
        public static let mostPopularCelebrities = "Most Popular Celebrities"
        public static let recentlyViewed = "Recently Viewed"
        public static let moreMoviewsFromFavouriteActor = "More movies from favourite actor"
        public static let news = "News"
    }

    // MARK: - Actions

    public enum Action {
        public static let seeAll = "See All"
    }

    // MARK: - Empty States

    public enum EmptyState {
        public static let recentlyViewedTitle = "No recently viewed yet"
        public static let recentlyViewedSubtitle = "Once you start browsing, come back here to see your history."
    }

    // MARK: - Screen Content

    public enum Content {
        public static let actor = "Actor"
        public static let top10Title = "Top 10"
        public static let nowStreaming = "Now Streaming"
        public static let comingSoon = "Coming Soon"
        public static let fromYourWatchlist = "From Your Watchlist"
        public static let trendingNow = "Trending Now"
        public static let yourFavouritePeople = "Your Favourite People"
        public static let topNews = "Top News"
        public static let movies = "Movies"
        public static let refreshingNews = "Refreshing news…"
        public static let newsIsTemporarilyUnavailable = "News is temporarily unavailable"
        public static let tryAgain = "Try Again"
        public static let becauseTheyreOneOfYourFavouritePeople = "because they're one of your favourite people"
        public static let seeYourFavouritePeople = "See your favourite people"
        public static let searchAction = "Search"
        public static let whatToWatch = "What to watch"
        public static let moreToExplore = "More to explore"
    }

    // MARK: - Formatted Text

    public enum Format {
        public static func moreFrom(actorName: String) -> String { "More From \(actorName)" }
        public static func moreFromHeader(actorName: String) -> String { "More from \(actorName)" }
    }
}

//
//  SeeAllView.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI
import SharedCore

public struct SeeAllView: View {

    private let section: HomeSection

    public init(section: HomeSection) {
        self.section = section
    }

    public var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.title.bold())

            Text("See All")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemBackground))
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var title: String {
        switch section {
        case .header:
            "Header"
        case .bornToday:
            "Born Today"
        case .top10:
            "Top 10"
        case .fanFavourites:
            "Fan Favourites"
        case .nowPlaying:
            "Now Playing"
        case .upcoming:
            "Upcoming"
        case .fromYourWatchlist:
            "From Your Watchlist"
        case .trending:
            "Trending"
        case .popularActors:
            "Popular Actors"
        case .watchlist:
            "Watchlist"
        case .moreFromActor:
            "More From Actor"
        case .news:
            "News"
        case .mostPopularCelebrities:
            "Most Popular Celebrities"
        case .recentlyViewed:
            "Recently Viewed"
        case .filmography:
            "Filmography"
        }
    }
}

//
//  HomeHeaderView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import SwiftUI
import HomeDomain
import SharedCore
import DesignSystemTokens

struct HomeHeaderView: View {

    // MARK: - Properties

    let featuredItems: [FeaturedItem]
    let watchlistedMovieIDs: Set<Int>

    let onVideoTap: (FeaturedItem) -> Void
    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void
    let onSearchTap: () -> Void

    // MARK: - Body

    var body: some View {

        VStack(spacing: 0) {

            featuredSection

            searchButton
        }
        .background(
            ColorTokens.Background.primary
        )
    }

    // MARK: - Featured Section

    @ViewBuilder
    private var featuredSection: some View {

        if !featuredItems.isEmpty {

            FeaturedHorizontalScrollView(
                featuredItems: featuredItems,
                isWatchlisted: {
                    watchlistedMovieIDs.contains($0)
                },
                onVideoTap: onVideoTap,
                onMovieTap: onMovieTap,
                onWatchlistTap: onWatchlistTap
            )
        }
    }

    // MARK: - Search Button

    private var searchButton: some View {

        Button(action: onSearchTap) {

            HStack(spacing: 5) {

                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                    .frame(width: 40)

                Text("Search for shows, movies, people...")
                    .foregroundStyle(.secondary)
                    .font(
                        Font.system(
                            size: 17,
                            weight: .regular,
                            design: .rounded
                        )
                    )

                Spacer()
            }
            .padding(.horizontal, 5)
            .frame(height: 30)
            .frame(maxWidth: .infinity)
            .background(.white.opacity(0.5))
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
            ColorTokens.Background.primary
        )
        .accessibilityLabel("Search")
    }
}

// MARK: - Featured Horizontal Scroll

private struct FeaturedHorizontalScrollView: View {

    let featuredItems: [FeaturedItem]

    let isWatchlisted: (Int) -> Bool

    let onVideoTap: (FeaturedItem) -> Void
    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void

    @State private var currentPage: Int?
    @State private var isUserInteracting = false
    @State private var resetInteractionTask: Task<Void, Never>?

    private let autoScrollInterval: UInt64 = 4_000_000_000

    var body: some View {

        ScrollView(.horizontal) {

            HStack(spacing: 0) {

                ForEach(featuredItems) { item in

                    posterWithVideoView(
                        for: item
                    )
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .scrollPosition(
            id: $currentPage
        )
        .frame(height: 260)
        .simultaneousGesture(
            DragGesture(minimumDistance: 10)
                .onChanged { _ in

                    isUserInteracting = true
                    resetInteractionTask?.cancel()
                }
                .onEnded { _ in

                    resetInteractionTask = Task {

                        try? await Task.sleep(
                            nanoseconds: autoScrollInterval
                        )

                        if !Task.isCancelled {
                            isUserInteracting = false
                        }
                    }
                }
        )
        .task(id: featuredItems.count) {
            await autoScroll()
        }
    }

    // MARK: - Poster With Video

    private func posterWithVideoView(
        for item: FeaturedItem
    ) -> some View {

        PosterWithVideoView(
            featuredItem: item,
            isWatchlisted: isWatchlisted(item.movie.id),
            onVideoTap: {
                onVideoTap(item)
            },
            onMovieTap: {
                onMovieTap(item.movie)
            },
            onWatchlistTap: {
                onWatchlistTap(item.movie)
            }
        )
        .containerRelativeFrame(.horizontal)
        .frame(height: 260)
        .id(item.id)
    }

    // MARK: - Auto Scroll

    private func autoScroll() async {

        guard featuredItems.count > 1 else {
            return
        }

        if currentPage == nil {
            currentPage = featuredItems.first?.id
        }

        while !Task.isCancelled {

            do {
                try await Task.sleep(
                    nanoseconds: autoScrollInterval
                )
            } catch {
                return
            }

            guard !Task.isCancelled else {
                return
            }

            guard !isUserInteracting else {
                continue
            }

            guard
                let currentPage,
                let currentIndex = featuredItems.firstIndex(
                    where: {
                        $0.id == currentPage
                    }
                )
            else {
                continue
            }

            let nextIndex =
                (currentIndex + 1)
                % featuredItems.count

            withAnimation(
                .easeInOut(duration: 0.5)
            ) {
                self.currentPage =
                    featuredItems[nextIndex].id
            }
        }
    }
}

// MARK: - Poster With Video

private struct PosterWithVideoView: View {

    let featuredItem: FeaturedItem

    let isWatchlisted: Bool

    let onVideoTap: () -> Void
    let onMovieTap: () -> Void
    let onWatchlistTap: () -> Void

    var body: some View {

        VStack(spacing: 0) {

            ZStack(alignment: .bottomLeading) {

                VStack(spacing: 0) {

                    backgroundButton

                    footer
                }

                moviePoster
                    .frame(
                        width: 100,
                        height: 150
                    )
                    .padding(.leading, 20)
            }
            .background(
                ColorTokens.Background.primary
            )
        }
    }

    // MARK: - Video

    private var backgroundButton: some View {

        Button(action: onVideoTap) {

            ZStack {

                videoImage

                Image(systemName: "play.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(.plain)
    }

    // MARK: - Video Image

    private var videoImage: some View {

        AsyncImage(
            url: videoThumbnailURL
        ) { phase in

            switch phase {

            case .empty:

                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay {
                        ProgressView()
                    }

            case .success(let image):

                image
                    .resizable()
                    .scaledToFill()

            case .failure:

                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(.gray)
                    }

            @unknown default:

                EmptyView()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 210)
        .clipped()
    }

    // MARK: - Footer

    private var footer: some View {

        HStack {

            Color.clear
                .frame(
                    width: 110,
                    height: 50
                )

            Text(featuredItem.video.name)
                .foregroundColor(
                    ColorTokens.Text.primary
                )
                .font(
                    .system(
                        size: 13,
                        weight: .regular
                    )
                )
                .foregroundStyle(
                    .black.opacity(0.8)
                )
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Spacer()
        }
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity)
    }

    // MARK: - Movie Poster

    private var moviePoster: some View {

        ZStack(alignment: .topLeading) {

            Button(action: onMovieTap) {

                AsyncImage(
                    url: URL(
                        string:
                            featuredItem.movie.posterPath ?? ""
                    )
                ) { phase in

                    switch phase {

                    case .empty:

                        Rectangle()
                            .fill(
                                Color.gray.opacity(0.3)
                            )
                            .overlay {
                                ProgressView()
                            }

                    case .success(let image):

                        image
                            .resizable()
                            .scaledToFill()

                    case .failure:

                        Rectangle()
                            .fill(
                                Color.gray.opacity(0.3)
                            )
                            .overlay {
                                Image(
                                    systemName: "photo"
                                )
                                .foregroundStyle(.gray)
                            }

                    @unknown default:

                        EmptyView()
                    }
                }
            }
            .buttonStyle(.plain)

            LinearGradient(
                colors: [
                    .black.opacity(0.6),
                    .clear
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 70)

            WatchlistButton(
                isAdded: isWatchlisted,
                action: onWatchlistTap
            )
        }
        .clipped()
    }

    // MARK: - YouTube Thumbnail

    private var videoThumbnailURL: URL? {

        guard featuredItem.video.site == .youtube else {
            return nil
        }

        return URL(
            string:
                "https://img.youtube.com/vi/\(featuredItem.video.key)/hqdefault.jpg"
        )
    }
}

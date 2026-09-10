//
//  FeaturedHorizontalScrollView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 13/08/2026.
//

import SwiftUI
import LibraryDomain
import SharedCore
import HomeDomain
import DesignSystemTokens

public struct FeaturedHorizontalScrollView: View {

    // MARK: - Properties

    let featuredItems: [FeaturedItem]

    let isWatchlisted: (Int) -> Bool

    let onVideoTap: (FeaturedItem) -> Void
    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void

    @State
    private var currentPage: Int?
    @State
    private var isUserInteracting = false
    @State
    private var resetInteractionTask: Task<Void, Never>?

    private let autoScrollInterval: UInt64 = 4_000_000_000

    // MARK: - Body

    public var body: some View {

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
        .scrollPosition(id: $currentPage)
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

    private func posterWithVideoView(for item: FeaturedItem) -> some View {

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

//
//  FeaturedHorizontalScrollView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 05/08/2026.
//

import SwiftUI
import SharedCore
import HomeDomain

struct FeaturedHorizontalScrollView: View {

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
                        try? await Task.sleep(nanoseconds: autoScrollInterval)
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
                try await Task.sleep(nanoseconds: autoScrollInterval)
            } catch {
                return
            }

            guard !Task.isCancelled else {
                return
            }

            // თუ მომხმარებელი ეხება კარუსელს, ამ ბრუნს გამოვტოვებთ
            guard !isUserInteracting else {
                continue
            }

            guard
                let currentPage,
                let currentIndex = featuredItems.firstIndex(
                    where: { $0.id == currentPage }
                )
            else {
                continue
            }

            let nextIndex = (currentIndex + 1) % featuredItems.count

            withAnimation(.easeInOut(duration: 0.5)) {
                self.currentPage = featuredItems[nextIndex].id
            }
        }
    }
}

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

    let onVideoTap: (FeaturedItem) -> Void

    @State private var watchlistMovieIDs: Set<Int> = []

    var body: some View {

        GeometryReader { geometry in

            ScrollView(
                .horizontal,
                showsIndicators: false
            ) {

                LazyHStack(spacing: 0) {

                    ForEach(featuredItems) { item in

                        PosterWithVideoView(
                            featuredItem: item,
                            addedInWatchlist: Binding(
                                get: {
                                    watchlistMovieIDs.contains(
                                        item.movie.id
                                    )
                                },
                                set: { isAdded in

                                    if isAdded {
                                        watchlistMovieIDs.insert(
                                            item.movie.id
                                        )
                                    } else {
                                        watchlistMovieIDs.remove(
                                            item.movie.id
                                        )
                                    }
                                }
                            ),
                            onVideoTap: {
                                onVideoTap(item)
                            }
                        )
                        .frame(
                            width: geometry.size.width,
                            height: 300
                        )
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
        }
        .frame(height: 300)
    }
}

// MARK: - Preview

#Preview {

    let movies = [

        Movie(
            id: 1,
            title: "Spider-Man: No Way Home",
            overview: "",
            posterPath:
                "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
            backdropPath: nil,
            releaseDate: "2021-12-17",
            voteAverage: 8.9,
            voteCount: 12000
        ),

        Movie(
            id: 2,
            title: "The Dark Knight",
            overview: "",
            posterPath:
                "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
            backdropPath: nil,
            releaseDate: "2008-07-18",
            voteAverage: 9.0,
            voteCount: 25000
        ),

        Movie(
            id: 3,
            title: "Inception",
            overview: "",
            posterPath:
                "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
            backdropPath: nil,
            releaseDate: "2010-07-16",
            voteAverage: 8.8,
            voteCount: 22000
        )
    ]

    let video = MovieVideo(
        id: "preview-video",
        key: "JfVOs4VSpmA",
        name: "Official Trailer",
        site: .youtube,
        type: .trailer,
        official: true
    )

    let items = movies.map {
        FeaturedItem(
            movie: $0,
            video: video
        )
    }

    FeaturedHorizontalScrollView(
        featuredItems: items,
        onVideoTap: { item in
            print(
                "Tapped movie:",
                item.movie.id
            )
        }
    )
}

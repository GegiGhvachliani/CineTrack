//
//  HomeView+Sections.swift
//  Home
//
//  Created by Gegi Ghvachliani on 10/08/2026.
//

import SwiftUI

import HomeDomain
import SharedCore
import DesignSystemTokens

extension HomeView {
    
    // MARK: - Header

    var header: some View {

        VStack(spacing: 0) {

            if !viewModel.featuredItems.isEmpty {

                FeaturedHorizontalScrollView(
                    featuredItems: viewModel.featuredItems,
                    isWatchlisted: {
                        viewModel.watchlistedMovieIDs.contains($0)
                    },
                    onVideoTap: { item in
                        print(
                            "Navigate to videos for movie:",
                            item.movie.id
                        )
                    },
                    onMovieTap: { movie in
                        
                        Task {
                            await viewModel.addRecentlyViewed(
                                movie: movie
                            )
                        }
                        
                        print(
                            "Navigate to movie:",
                            movie.id
                        )
                    },
                    onWatchlistTap: { movie in
                        viewModel.toggleWatchlist(for: movie)
                    }
                )
            }

            SearchButtonView {
                print("Navigate to Search")
            }
        }
        .background(
            ColorTokens.Background.primary
        )
    }

    // MARK: - Born Today

    var bornTodaySection: some View {

        HorizontalScrollView(
            headerText: "Born Today",
            items: viewModel.bornTodayActors,
            onSeeAllTap: {
                print("Navigate to Actors See All")
            },
            onLoadMore: {
                Task {
                    await viewModel.loadNextBornTodayActorsPage()
                }
            }
        ) { actor, _ in

            MovieActorCell(
                actor: actor,
                cellHeight: 240,
                isFavourited:
                    viewModel.favouritedActorIDs.contains(actor.id),
                onActorTap: {

                    Task {
                        await viewModel.addRecentlyViewed(
                            actor: actor
                        )
                    }

                    print(
                        "Navigate to actor:",
                        actor.name
                    )
                },
                onFavouriteTap: {
                    viewModel.toggleFavourite(
                        for: actor
                    )
                }
            )
        }
    }

    // MARK: - Top 10

    var top10SectionSection: some View {

        VStack {

            Text("What to watch")
                .font(TypographyTokens.title3)
                .foregroundColor(
                    ColorTokens.Brand.primary
                )
                .fontWeight(.bold)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )

            HorizontalScrollView(
                headerText: "Top 10 on CineTrack this week",
                items: viewModel.top10Movies,
                onSeeAllTap: {
                    print(
                        "Navigate to top 10 See All"
                    )
                }
            ) { movie, index in

                Top10MovieCell(
                    movie: movie,
                    isWatchlisted:
                        viewModel.watchlistedMovieIDs.contains(
                            movie.id
                        ),
                    cellHeight: 265,
                    ratingNumber: index + 1,
                    onMovieTap: {

                        Task {
                            await viewModel.addRecentlyViewed(
                                movie: movie
                            )
                        }

                        print(
                            "Navigate to movie:",
                            movie.id
                        )
                    },
                    onWatchlistTap: {
                        viewModel.toggleWatchlist(
                            for: movie
                        )
                    }
                )
            }
        }
    }

    // MARK: - Fan Favourites

    var fanFavouritesSection: some View {

        HorizontalScrollView(
            headerText: "Fan Favourites",
            items: viewModel.fanFavouriteMovies,
            onSeeAllTap: {
                print(
                    "Navigate to Fan Favourites See All"
                )
            },
            onLoadMore: {
                Task {
                    await viewModel.loadNextFanFavouritePage()
                }
            }
        ) { movie, _ in

            MovieCell(
                movie: movie,
                isWatchlisted:
                    viewModel.watchlistedMovieIDs.contains(
                        movie.id
                    ),
                cellHeight: 240,
                onMovieTap: {

                    Task {
                        await viewModel.addRecentlyViewed(
                            movie: movie
                        )
                    }

                    print(
                        "Navigate to movie:",
                        movie.id
                    )
                },
                onWatchlistTap: {
                    viewModel.toggleWatchlist(
                        for: movie
                    )
                }
            )
        }
    }

    // MARK: - Now Streaming

    var nowStreaming: some View {

        VStack(spacing: 0) {

            HorizontalScrollView(
                headerText: "Now streaming",
                items: viewModel.nowPlayingMovies,
                onSeeAllTap: {
                    print(
                        "Navigate to now streaming See All"
                    )
                },
                onLoadMore: {
                    Task {
                        await viewModel.loadNextNowPlayingPage()
                    }
                }
            ) { movie, _ in

                MovieCell(
                    movie: movie,
                    isWatchlisted:
                        viewModel.watchlistedMovieIDs.contains(
                            movie.id
                        ),
                    cellHeight: 240,
                    onMovieTap: {

                        Task {
                            await viewModel.addRecentlyViewed(
                                movie: movie
                            )
                        }

                        print(
                            "Navigate to movie:",
                            movie.id
                        )
                    },
                    onWatchlistTap: {
                        viewModel.toggleWatchlist(
                            for: movie
                        )
                    }
                )
            }

            MovieWebButtonsView()
        }
    }

    // MARK: - Coming Soon To Theaters

    var comingSoonToTheaters: some View {

        HorizontalScrollView(
            headerText: "Coming Soon To Theaters (US)",
            items: viewModel.upcomingMovies,
            onSeeAllTap: {
                print(
                    "Navigate Coming Soon To Theaters (US) movies See All"
                )
            },
            onLoadMore: {
                Task {
                    await viewModel.loadNextUpcomingPage()
                }
            }
        ) { movie, _ in

            ComingSoonMoviesCell(
                movie: movie,
                isWatchlisted:
                    viewModel.watchlistedMovieIDs.contains(
                        movie.id
                    ),
                cellHeight: 265,
                onMovieTap: {

                    Task {
                        await viewModel.addRecentlyViewed(
                            movie: movie
                        )
                    }

                    print(
                        "Navigate to movie:",
                        movie.id
                    )
                },
                onWatchlistTap: {
                    viewModel.toggleWatchlist(
                        for: movie
                    )
                }
            )
        }
    }

    // MARK: - Trending

    var trendingNow: some View {

        HorizontalScrollView(
            headerText: "Trending Now",
            items: viewModel.trendingMovies,
            onSeeAllTap: {
                print(
                    "Navigate to Trending See All"
                )
            },
            onLoadMore: {
                Task {
                    await viewModel.loadNextTrendingPage()
                }
            }
        ) { movie, _ in

            MovieCell(
                movie: movie,
                isWatchlisted:
                    viewModel.watchlistedMovieIDs.contains(
                        movie.id
                    ),
                cellHeight: 240,
                onMovieTap: {

                    Task {
                        await viewModel.addRecentlyViewed(
                            movie: movie
                        )
                    }

                    print(
                        "Navigate to movie:",
                        movie.id
                    )
                },
                onWatchlistTap: {
                    viewModel.toggleWatchlist(
                        for: movie
                    )
                }
            )
        }
    }

    // MARK: - News

    var newsSection: some View {

        HorizontalScrollView(
            headerText: "News",
            items: viewModel.news,
            onSeeAllTap: {
                print(
                    "Navigate to News See All"
                )
            },
            onLoadMore: {
                Task {
                    await viewModel.loadNextNewsPage()
                }
            }
        ) { news, _ in

            NewsCell(
                news: news,
                cellHeight: 220
            )
        }
    }

    // MARK: - Most Popular Actors

    var mostPopularActorsSection: some View {

        HorizontalScrollView(
            headerText: "Most Popular Actors",
            items: viewModel.mostPopularActors,
            onSeeAllTap: {
                print(
                    "Navigate to Actors See All"
                )
            },
            onLoadMore: {
                Task {
                    await viewModel
                        .loadNextMostPopularCelebritiesPage()
                }
            }
        ) { actor, _ in

            MovieActorCell(
                actor: actor,
                cellHeight: 240,
                isFavourited:
                    viewModel.favouritedActorIDs.contains(
                        actor.id
                    ),
                onActorTap: {

                    Task {
                        await viewModel.addRecentlyViewed(
                            actor: actor
                        )
                    }

                    print(
                        "Navigate to actor:",
                        actor.name
                    )
                },
                onFavouriteTap: {
                    viewModel.toggleFavourite(
                        for: actor
                    )
                }
            )
        }
    }
    
    // MARK: - Recently Viewed

    @ViewBuilder
    var recentlyViewed: some View {

        if viewModel.recentlyViewedItems.isEmpty {

            recentlyViewedEmptyState

        } else {

            HorizontalScrollView(
                headerText: "Recently viewed",
                items: viewModel.recentlyViewedItems,
                onSeeAllTap: {
                    print(
                        "Navigate to Recently Viewed See All"
                    )
                }
            ) { item, _ in

                recentlyViewedCell(
                    for: item
                )
            }
        }
    }

    // MARK: - Recently Viewed Cell

    @ViewBuilder
    private func recentlyViewedCell(
        for item: RecentlyViewedItem
    ) -> some View {

        switch item {

        case .movie(let recentlyViewedMovie):

            let movie = Movie(
                id: recentlyViewedMovie.id,
                title: recentlyViewedMovie.title,
                overview: "",
                posterPath: recentlyViewedMovie.posterPath,
                backdropPath: nil,
                releaseDate: recentlyViewedMovie.releaseDate,
                voteAverage: recentlyViewedMovie.voteAverage,
                voteCount: 0
            )

            MovieCell(
                movie: movie,
                isWatchlisted:
                    viewModel.watchlistedMovieIDs.contains(
                        movie.id
                    ),
                cellHeight: 240,
                onMovieTap: {

                    Task {
                        await viewModel.addRecentlyViewed(
                            movie: movie
                        )
                    }

                    print(
                        "Navigate to movie:",
                        movie.id
                    )
                },
                onWatchlistTap: {

                    viewModel.toggleWatchlist(
                        for: movie
                    )
                }
            )

        case .actor(let recentlyViewedActor):

            let actor = Actor(
                id: recentlyViewedActor.id,
                name: recentlyViewedActor.name,
                birthday: recentlyViewedActor.birthday,
                profilePath: recentlyViewedActor.profilePath
            )

            MovieActorCell(
                actor: actor,
                cellHeight: 240,
                isFavourited:
                    viewModel.favouritedActorIDs.contains(
                        actor.id
                    ),
                onActorTap: {

                    Task {
                        await viewModel.addRecentlyViewed(
                            actor: actor
                        )
                    }

                    print(
                        "Navigate to actor:",
                        actor.name
                    )
                },
                onFavouriteTap: {

                    viewModel.toggleFavourite(
                        for: actor
                    )
                }
            )
        }
    }

    // MARK: - Recently Viewed Empty State

    private var recentlyViewedEmptyState: some View {

        VStack(spacing: 20) {

            HStack(spacing: 8) {

                Capsule()
                    .frame(
                        width: 4,
                        height: 25
                    )
                    .foregroundStyle(
                        ColorTokens.Brand.primary
                    )

                Text("Recently viewed")
                    .font(
                        TypographyTokens.headline
                    )

                Spacer()
            }
            .padding(.horizontal)

            VStack(spacing: 10) {

                Text("No recently viewed yet")
                    .font(
                        TypographyTokens.bodySmall
                    )
                    .frame(
                        maxWidth: .infinity,
                        alignment: .center
                    )
                    .padding(.horizontal, 40)

                Text(
                    "Once you start browsing, come back here to see your history."
                )
                .font(
                    TypographyTokens.caption
                )
                .multilineTextAlignment(.center)
                .frame(
                    maxWidth: .infinity,
                    alignment: .center
                )
                .foregroundStyle(.secondary)
                .padding(.horizontal, 20)
            }
        }
        .padding(.vertical, 15)
        .padding(.bottom, 15)
        .background(
            ColorTokens.Background.secondary
        )
    }
}


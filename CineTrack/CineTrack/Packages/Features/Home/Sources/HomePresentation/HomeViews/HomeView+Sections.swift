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
                    print("Navigate to actor:", actor.name)
                },
                onFavouriteTap: {
                    viewModel.toggleFavourite(for: actor)
                }
            )
        }
    }

    // MARK: - Top 10

    var top10SectionSection: some View {
        VStack {

            Text("What to watch")
                .font(TypographyTokens.title3)
                .foregroundColor(ColorTokens.Brand.primary)
                .fontWeight(.bold)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )

            HorizontalScrollView(
                headerText: "Top 10 on CineTrack this week",
                items: viewModel.top10Movies,
                onSeeAllTap: {
                    print("Navigate to top 10 See All")
                }
            ) { movie, index in

                Top10MovieCell(
                    movie: movie,
                    isWatchlisted:
                        viewModel.watchlistedMovieIDs.contains(movie.id),
                    cellHeight: 265,
                    ratingNumber: index + 1,
                    onMovieTap: {
                        print("Navigate to movie:", movie.id)
                    },
                    onWatchlistTap: {
                        viewModel.toggleWatchlist(for: movie)
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
                print("Navigate to Fan Favourites See All")
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
                    viewModel.watchlistedMovieIDs.contains(movie.id),
                cellHeight: 240,
                onMovieTap: {
                    print("Navigate to movie:", movie.id)
                },
                onWatchlistTap: {
                    viewModel.toggleWatchlist(for: movie)
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
                    print("Navigate to now streaming See All")
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
                        viewModel.watchlistedMovieIDs.contains(movie.id),
                    cellHeight: 240,
                    onMovieTap: {
                        print("Navigate to movie:", movie.id)
                    },
                    onWatchlistTap: {
                        viewModel.toggleWatchlist(for: movie)
                    }
                )
            }

            MovieWebButtonsView()
        }
    }

    // MARK: - Coming Soon To Theaters

    var comingSoonToTheaters: some View {

        HorizontalScrollView(
            headerText: "Coming Soon To Theaters (GEO)",
            items: viewModel.upcomingMovies,
            onSeeAllTap: {
                print(
                    "Navigate Coming Soon To Theaters (GEO) movies See All"
                )
            },
            onLoadMore: {
                Task {
                    await viewModel.loadNextUpcomingPage()
                }
            }
        ) { movie, _ in

            MovieCell(
                movie: movie,
                isWatchlisted:
                    viewModel.watchlistedMovieIDs.contains(movie.id),
                cellHeight: 240,
                onMovieTap: {
                    print("Navigate to movie:", movie.id)
                },
                onWatchlistTap: {
                    viewModel.toggleWatchlist(for: movie)
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
                print("Navigate to Trending See All")
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
                    viewModel.watchlistedMovieIDs.contains(movie.id),
                cellHeight: 240,
                onMovieTap: {
                    print("Navigate to movie:", movie.id)
                },
                onWatchlistTap: {
                    viewModel.toggleWatchlist(for: movie)
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
                print("Navigate to News See All")
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
                print("Navigate to Actors See All")
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
                    viewModel.favouritedActorIDs.contains(actor.id),
                onActorTap: {
                    print(
                        "Navigate to actor:",
                        actor.name
                    )
                },
                onFavouriteTap: {
                    viewModel.toggleFavourite(for: actor)
                }
            )
        }
    }

    // MARK: - Recently Viewed

    @ViewBuilder
    var recentlyViewed: some View {

        let recentlyViewedArray: [Movie] = []

        if recentlyViewedArray.isEmpty {

            VStack(spacing: 20) {

                HStack(spacing: 8) {

                    Capsule()
                        .frame(width: 4, height: 25)
                        .foregroundStyle(
                            ColorTokens.Brand.primary
                        )

                    Text("Recently viewed")
                        .font(TypographyTokens.headline)

                    Spacer()
                }
                .padding(.horizontal)

                VStack(spacing: 10) {

                    Text("No recently viewed yet")
                        .font(TypographyTokens.bodySmall)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .center
                        )
                        .padding(.horizontal, 40)

                    Text(
                        "Once you start browsing, come back here to see your history."
                    )
                    .font(TypographyTokens.caption)
                    .multilineTextAlignment(.center)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .center
                    )
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 20)
                }
            }
            .padding(.vertical, 15)
            .padding(.bottom, 15)
            .background(
                ColorTokens.Background.secondary
            )

        } else {

            HorizontalScrollView(
                headerText: "Recently viewed",
                items: recentlyViewedArray,
                onSeeAllTap: {
                    print(
                        "Navigate to Recently Viewed See All"
                    )
                }
            ) { movie, _ in

                MovieCell(
                    movie: movie,
                    isWatchlisted:
                        viewModel.watchlistedMovieIDs.contains(movie.id),
                    cellHeight: 240,
                    onMovieTap: {
                        print("Navigate to movie:", movie.id)
                    },
                    onWatchlistTap: {
                        viewModel.toggleWatchlist(for: movie)
                    }
                )
            }
        }
    }
}

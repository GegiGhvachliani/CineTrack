//
//  HomeView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 02/08/2026.
//

import SwiftUI
import HomeDomain
import SharedCore
import DesignSystemTokens

public struct HomeView: View {

    @State private var viewModel: HomeViewModel

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {

        ScrollView {

            VStack(spacing: 20) {

                header
                
                bornTodaySection
                
                
                top10SectionSection
                comingSoonToTheaters
                nowStreaming
                trendingNow
                
                newsSection
                recentlyViewed
                
                FollowCinetrackWithLinksView()

            }
        }
        .ignoresSafeArea(edges: .vertical)
        .padding(.top)
        .scrollIndicators(.hidden)
        .task {
            await viewModel.loadHome()
        }
        .padding(.bottom, 50)
    }
    
    // MARK: - Header
    
    private var header: some View {
        VStack(spacing: 0) {
            if !viewModel.featuredItems.isEmpty {

                FeaturedHorizontalScrollView(
                    featuredItems: viewModel.featuredItems,
                    isWatchlisted: {
                        viewModel.watchlistedMovieIDs.contains($0)
                    },
                    onVideoTap: { item in
                        print("Navigate to videos for movie:", item.movie.id )
                    },
                    onMovieTap: { movie in
                        print("Navigate to movie:", movie.id)
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
        .background(ColorTokens.Background.primary)
    }
    
    // MARK: - Born Today
    
    private var bornTodaySection: some View {
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
                isFavourited: viewModel.favouritedActorIDs.contains(actor.id),
                onActorTap: {
                    print("Navigate to actor:", actor.name)
                },
                onFavouriteTap: {
                    viewModel.toggleFavourite(for: actor)
                }
            )
        }
    }
    
    // MARK: - Top 10 on CineTrack this week
    
    private var top10SectionSection: some View {
        VStack {
            
            Text("What to watch")
                .font(TypographyTokens.title3)
                .foregroundColor(ColorTokens.Brand.primary)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HorizontalScrollView(
                headerText: "Top 10 on CineTrack this week",
                items: viewModel.topRatedMovies,
                onSeeAllTap: {
                    print("Navigate to top 10 See All")
                },
                onLoadMore: {
                    Task {
                        await viewModel.loadNextTopRatedPage()
                    }
                }
            ) { movie, _ in
                
                MovieCell(
                    movie: movie,
                    isWatchlisted: viewModel.watchlistedMovieIDs.contains(movie.id),
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
    
    // MARK: - Now Streaming
    
    private var nowStreaming: some View {
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
                    isWatchlisted: viewModel.watchlistedMovieIDs.contains(movie.id),
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
    
    // MARK: - Coming Soon To Theaters (GEO)
    
    private var comingSoonToTheaters: some View {
        
        HorizontalScrollView(
            headerText: "Coming Soon To Theaters (GEO)",
            items: viewModel.upcomingMovies,
            onSeeAllTap: {
                print("Navigate Coming Soon To Theaters (GEO) movies See All")
            },
            onLoadMore: {
                Task {
                    await viewModel.loadNextUpcomingPage()
                }
            }
        ) { movie, _ in

            MovieCell(
                movie: movie,
                isWatchlisted: viewModel.watchlistedMovieIDs.contains(movie.id),
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
    
    // MARK: - Trending Movies
    
    private var trendingNow: some View {
        
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
                isWatchlisted: viewModel.watchlistedMovieIDs.contains(movie.id),
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

    private var newsSection: some View {
        VStack (spacing: 10) {
            
        Text("More to Explore")
                .font(TypographyTokens.title3)
                .foregroundColor(ColorTokens.Brand.primary)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HorizontalScrollView(
                headerText: "Top News",
                items: sampleNews,
                onSeeAllTap: {
                    print("Navigate to News See All")
                }
            ) { news, _ in
            
            NewsCell(
                news: news,
                cellHeight: 200
            )
        }
    }
    }
    
    // MARK: - Recently viewed
    
    @ViewBuilder
    private var recentlyViewed: some View {
        // იდეალურ შემთხვევაში, ეს მონაცემი viewModel-დან უნდა მოდიოდეს
        // მაგალითად: let recentlyViewedArray = viewModel.recentlyViewedMovies
        let recentlyViewedArray: [Movie] = []
        
        if recentlyViewedArray.isEmpty {
            VStack(spacing: 20) {
                
                HStack(spacing: 8) {
                    Capsule()
                        .frame(width: 4, height: 25)
                        .foregroundStyle(ColorTokens.Brand.primary)

                    Text("Recently viewed") // გასწორდა ტაიპო
                        .font(TypographyTokens.headline)

                    Spacer()
                }
                .padding(.horizontal)
                
                VStack(spacing: 10) {
                    Text("No recently viewed yet")
                        .font(TypographyTokens.bodySmall)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 40)
                    
                    Text("Once you start browsing, come back here to see your history.")
                        .font(TypographyTokens.caption)
                        .multilineTextAlignment(.center)
                        .frame(alignment: .center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 20)
                }
            }
            .padding(.vertical, 15)
            .padding(.bottom, 15)
            .background(ColorTokens.Background.secondary)
        } else {
            HorizontalScrollView(
                headerText: "Recently viewed", // შეიცვალა სათაური
                items: recentlyViewedArray,    // trendingMovies-ის ნაცვლად გადაეწოდა recentlyViewedArray
                onSeeAllTap: {
                    print("Navigate to Recently Viewed See All")
                }
            ) { movie, _ in
                
                MovieCell(
                    movie: movie,
                    isWatchlisted: viewModel.watchlistedMovieIDs.contains(movie.id),
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
    

    private var sampleMovies: [Movie] {
        [
            Movie(
                id: 3,
                title: "Loading...",
                overview: "",
                posterPath: "",
                backdropPath: nil,
                releaseDate: nil,
                voteAverage: 0.0,
                voteCount: 0
            )
        ]
    }
    
    private let sampleNews: [News] = [
        
        News(
            photoURL: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
            artcleAuthor: "BBC News",
            articleTitle: "Christopher Nolan's new movie becomes one of the biggest releases of the year",
            article: "The latest movie news, interviews and updates from the entertainment world.",
            date: "3"
        ),
        
        News(
            photoURL: "https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
            artcleAuthor: "Variety",
            articleTitle: "Hollywood prepares for another major award season",
            article: "Studios announce new projects and upcoming releases for audiences worldwide.",
            date: "8"
        ),
        
        News(
            photoURL: "https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg",
            artcleAuthor: "IMDb",
            articleTitle: "Most anticipated ",
            article: "Fans are waiting for several major movies arriving in theaters soon.",
            date: "12"
        )
    ]
}

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

    // MARK: - ViewModel

    @State var viewModel: HomeViewModel

    // MARK: - Initialization

    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    public var body: some View {

        ScrollView {

            VStack(spacing: 20) {

                header

                bornTodaySection

                top10Section

                fanFavouritesSection

                comingSoonToTheatersSection
                nowStreamingSection
                trendingNowSection

                topNewsSection
                mostPopularCelebritiesSection
                recentlyViewedSection

                Text("More Movies From Favourite Actor")
                    .font(TypographyTokens.title3)
                    .foregroundColor(ColorTokens.Brand.primary)
                
                footer
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
    
    // MARK: - header
    
    private var header: some View {
        
        HomeHeaderView(
            featuredItems: viewModel.featuredItems,
            watchlistedMovieIDs: viewModel.watchlistedMovieIDs,

            onVideoTap: { item in
                print("Navigate to videos for movie:", item.movie.id)
            },

            onMovieTap: { movie in
                Task {
                    await viewModel.addRecentlyViewed(movie: movie)
                }

                print("Navigate to movie:", movie.id)
            },

            onWatchlistTap: { movie in
                Task {
                    await viewModel.toggleWatchlist(for: movie)
                }
            },

            onSearchTap: {
                print("Navigate to Search")
            }
        )
        
    }
    
    // MARK: - Born Today
    
    private var bornTodaySection: some View {
        
        BornTodaySectionView(
            actors: viewModel.bornTodayActors,
            favouriteActorIDs: viewModel.favouritedActorIDs,
            onActorTap: { actor in
                
                Task {
                    await viewModel.addRecentlyViewed(actor: actor)
                }
                
            }, onFavouriteTap: { actor in
                
                Task {
                    await viewModel.toggleFavourite(for: actor)
               }
                
            }, onSeeAllTap: {
                
                print("see all tapped")
                
            }, onLoadMore: {
                
                Task {
                    await viewModel.loadNextBornTodayActorsPage()
                }
                
            }
        )
    }
    
    // MARK: - Top 10
    
    private var top10Section: some View {
        
        Top10SectionView(
            movies: viewModel.top10Movies,
            watchlistedMovieIDs: viewModel.watchlistedMovieIDs
        ) { movie in
                Task {
                    await viewModel.addRecentlyViewed(movie: movie)
                }
                
                print("Navigate to movie details")
                
            } onWatchlistTap: { movie in
                
                Task {
                    await viewModel.toggleWatchlist(for: movie)
                }
                
            } onSeeAllTap: {
                
                print("See all tapped")
                
            }
    }
    
    // MARK: - Fan Favourites
    
    private var fanFavouritesSection: some View {
        
        FanFavouritesSectionView(
            movies: viewModel.fanFavouriteMovies,
            watchlistedMovieIDs: viewModel.watchlistedMovieIDs,
            onMovieTap: { movie in
            
                Task {
                    await viewModel.addRecentlyViewed(movie: movie)
                }
                
            }, onWatchlistTap: { movie in
                
                Task {
                    await viewModel.toggleWatchlist(for: movie)
                }
                
            }, onSeeAllTap: {
                
                print("See All Tapped")

            }, onLoadMore: {
                
                Task {
                    await viewModel.loadNextFanFavouritePage()
                }
                
            }
        )
    }

    // MARK: - Now Steaming
    
    private var nowStreamingSection: some View {
        
        VStack(spacing: 0) {
            NowStreamingSectionView(
                movies: viewModel.nowPlayingMovies,
                watchlistedMovieIDs: viewModel.watchlistedMovieIDs,
                onMovieTap: { movie in
                    
                    Task {
                        await viewModel.addRecentlyViewed(movie: movie)
                    }
                    
                },
                onWatchlistTap: { movie in
                    
                    Task {
                        await viewModel.toggleWatchlist(for: movie)
                    }
                    
                },
                onSeeAllTap: {
                    
                    print("See All Tapped")
                    
                },
                onLoadMore: {
                    
                    Task {
                        await viewModel.loadNextNowPlayingPage()
                    }
                    
                }
            )
            
            MovieWebButtonsView()

        }
        
    }
    
    // MARK: - Coming Soon To Theaters
    
    private var comingSoonToTheatersSection: some View {
        
        ComingSoonSectionView(
            movies: viewModel.upcomingMovies,
            watchlistedMovieIDs: viewModel.watchlistedMovieIDs, onMovieTap: { movie in
                
                Task {
                    await viewModel.addRecentlyViewed(movie: movie)
                }
                
            }, onWatchlistTap: { movie in
                
                Task {
                    await viewModel.toggleWatchlist(for: movie)
                }
                
            }, onSeeAllTap: {
                
                print("See All Tapped")
                
            }, onLoadMore: {
                
                Task {
                    await viewModel.loadNextUpcomingPage()
                }
                
            }
        )
    }
    
    // MARK: - Trending
    
    private var trendingNowSection: some View {
        
        TrendingSectionView(
            movies: viewModel.trendingMovies,
            watchlistedMovieID: viewModel.watchlistedMovieIDs,
            onMovieTap: { movie in
            
                Task {
                    await viewModel.addRecentlyViewed(movie: movie)
                }
                
            }, onWatchlistTap: { movie in
                
                Task {
                    await viewModel.toggleWatchlist(for: movie)
                }
                
            }, onSeeAllTap: {
                
                print("See All Tapped")
                
            }, onLoadMore: {
                
                Task {
                    await viewModel.loadNextTrendingPage()
                }
            }
        )
    }
    
    // TODO: - More From One of Favourite Actor
    
    // MARK: - Top News
    
    private var topNewsSection: some View {
        
        NewsSectionView(
            news: viewModel.news,
            onSeeAllTap: {
                print("See All Tapped")
            }, onNewsTap: { _ in
                
                print("Navigate to news details")
                
            }
        )
    }
    
    // MARK: - Most Popular Celebrities
    
    private var mostPopularCelebritiesSection: some View {
        
        MostPopularActorsSectionView(
            actors: viewModel.mostPopularActors,
            favouriteActorIDs: viewModel.favouritedActorIDs,
            onActorTap: { actor in
                
                Task {
                    await viewModel.addRecentlyViewed(actor: actor)
                }
                
            }, onFavouriteTap: { actor in
                
                Task {
                    await viewModel.toggleFavourite(for: actor)
                }
                
            }, onSeeAllTap: {
                
                print("See All Tapped")
                
            }, onLoadMore: {
                
                Task {
                    await viewModel.loadNextMostPopularCelebritiesPage()
                }
            }
        )
    }
    
    // MARK: - Recently Viewed
    
    private var recentlyViewedSection: some View {
            
        RecentlyViewedSectionView(
            items: viewModel.recentlyViewedItems,
            watchlistedMovieIDs: viewModel.watchlistedMovieIDs,
            favouritedActorIDs: viewModel.favouritedActorIDs,
            onMovieTap: { movie in
            
                Task {
                    await viewModel.addRecentlyViewed(movie: movie)
                }
                
            }, onWatchlistTap: { movie in
                
                Task {
                    await viewModel.toggleWatchlist(for: movie)
                }
                
            }, onActorTap: { actor in
            
                Task {
                    await viewModel.addRecentlyViewed(actor: actor)
                }
                
            }, onFavouriteTap: { actor in
            
                Task {
                    await viewModel.toggleFavourite(for: actor)
                }
                
            }, onSeeAllTap: {
                
                print("navigateToSeeALl")
            }
        )
    }
    
    // MARK: - Follow us
    
    private var footer: some View {
        
        HomeFooterView()
        
    }

}

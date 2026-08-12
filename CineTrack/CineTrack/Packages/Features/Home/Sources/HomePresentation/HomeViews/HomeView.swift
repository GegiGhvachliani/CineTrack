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
                
                whatToWatchDivider
                
                top10Section
                fanFavouritesSection
                comingSoonToTheatersSection
                nowStreamingSection
                trendingNowSection
                watchlistedMoviesSection

                moreToExplorDivider
                
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
            watchlistedMovies: viewModel.watchlistedMovies,
            onVideoTap: { item in
                viewModel.didTapVideos(item)
            },

            onMovieTap: { movie in
                
                viewModel.didTapMovie(movie)
                
                Task {
                    await viewModel.addRecentlyViewed(movie: movie)
                }
            },

            onWatchlistTap: { movie in
                
                Task {
                    await viewModel.toggleWatchlist(for: movie)
                }
            },

            onSearchTap: {
                
                viewModel.didTapSearch()
                
            }
        )
        
    }
    
    // MARK: - Born Today
    
    private var bornTodaySection: some View {
        
        BornTodaySectionView(
            actors: viewModel.bornTodayActors,
            favouritedActors: viewModel.favouritedActors,
            onActorTap: { actor in
                
                viewModel.didTapActor(actor)
                
                Task {
                    await viewModel.addRecentlyViewed(actor: actor)
                }
                
            }, onFavouriteTap: { actor in
                
                Task {
                    await viewModel.toggleFavourite(for: actor)
               }
                
            }, onSeeAllTap: {
                
                viewModel.didTapSeeAll(.bornToday)
                
            }, onLoadMore: {
                
                Task {
                    await viewModel.loadNextBornTodayActorsPage()
                }
                
            }
        )
    }
    
    // MARK: - Divider
    
    private var whatToWatchDivider: some View {
        
        Text("What to watch")
            .font(TypographyTokens.title2)
            .foregroundColor(ColorTokens.Brand.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            .offset(y: 10)
    }
    
    // MARK: - Top 10
    
    private var top10Section: some View {
        
        Top10SectionView(
            movies: viewModel.top10Movies,
            watchlistedMovies: viewModel.watchlistedMovies,
        ) { movie in
            
                viewModel.didTapMovie(movie)
            
                Task {
                    await viewModel.addRecentlyViewed(movie: movie)
                }
                
                print("Navigate to movie details")
                
            } onWatchlistTap: { movie in
                
                Task {
                    await viewModel.toggleWatchlist(for: movie)
                }
                
            } onSeeAllTap: {
                
                viewModel.didTapSeeAll(.top10)
                
            }
    }
    
    // MARK: - Fan Favourites
    
    private var fanFavouritesSection: some View {
        
        FanFavouritesSectionView(
            movies: viewModel.fanFavouriteMovies,
            watchlistedMovies: viewModel.watchlistedMovies,
            onMovieTap: { movie in
                
                viewModel.didTapMovie(movie)
            
                Task {
                    await viewModel.addRecentlyViewed(movie: movie)
                }
                
            }, onWatchlistTap: { movie in
                
                Task {
                    await viewModel.toggleWatchlist(for: movie)
                }
                
            }, onSeeAllTap: {
                
                viewModel.didTapSeeAll(.fanFavourites)

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
                watchlistedMovies: viewModel.watchlistedMovies,
                onMovieTap: { movie in
                    
                    viewModel.didTapMovie(movie)
                    
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
                    
                    viewModel.didTapSeeAll(.nowPlaying)
                    
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
            watchlistedMovies: viewModel.watchlistedMovies,
            onMovieTap: { movie in
                
                viewModel.didTapMovie(movie)
                
                Task {
                    await viewModel.addRecentlyViewed(movie: movie)
                }
                
            }, onWatchlistTap: { movie in
                
                Task {
                    await viewModel.toggleWatchlist(for: movie)
                }
                
            }, onSeeAllTap: {
                
                viewModel.didTapSeeAll(.upcoming)
                
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
            watchlistedMovies: viewModel.watchlistedMovies,
            onMovieTap: { movie in
            
                viewModel.didTapMovie(movie)
                
                Task {
                    await viewModel.addRecentlyViewed(movie: movie)
                }
                
            }, onWatchlistTap: { movie in
                
                Task {
                    await viewModel.toggleWatchlist(for: movie)
                }
                
            }, onSeeAllTap: {
                
                viewModel.didTapSeeAll(.trending)
                
            }, onLoadMore: {
                
                Task {
                    await viewModel.loadNextTrendingPage()
                }
            }
        )
    }
    
    // MARK: - From Watchlist
    @ViewBuilder
    private var watchlistedMoviesSection: some View {

        if !viewModel.watchlistedMovies.isEmpty {

            WatchlistedMoviesSesctionView(
                movies: viewModel.watchlistedMovies,
                watchlistedMovies: viewModel.watchlistedMovies,
                onMovieTap: { movie in

                    Task {
                        await viewModel.addRecentlyViewed(
                            movie: movie
                        )
                    }

                },
                onWatchlistTap: { movie in

                    Task {
                        await viewModel.toggleWatchlist(
                            for: movie
                        )
                    }

                },
                onSeeAllTap: {

                    viewModel.didTapSeeAll(.watchlist)

                },
                onLoadMore: {

                }
            )
        }
    }
    
    // TODO: - More From One of Favourite Actor
    
    // MARK: - Divider
    
    private var moreToExplorDivider: some View {
        
        Text("More to explore")
            .font(TypographyTokens.title2)
            .foregroundColor(ColorTokens.Brand.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            .offset(y: 10)
        
    }
    
    // MARK: - Top News
    
    private var topNewsSection: some View {
        
        NewsSectionView(
            news: viewModel.news,
            onSeeAllTap: {
                
                viewModel.didTapSeeAll(.news)
                
            }, onNewsTap: { news in
                
                viewModel.didTapNews(news)
                
            }
        )
    }
    
    // MARK: - Most Popular Celebrities
    
    private var mostPopularCelebritiesSection: some View {
        
        MostPopularActorsSectionView(
            actors: viewModel.mostPopularActors,
            favouriteActors: viewModel.favouritedActors,
            onActorTap: { actor in
                
                viewModel.didTapActor(actor)
                
                Task {
                    await viewModel.addRecentlyViewed(actor: actor)
                }
                
            }, onFavouriteTap: { actor in
                
                Task {
                    await viewModel.toggleFavourite(for: actor)
                }
                
            }, onSeeAllTap: {
                
                viewModel.didTapSeeAll(.mostPopularCelebrities)
                
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
            watchlistedMovies: viewModel.watchlistedMovies,
            favouritedActors: viewModel.favouritedActors,
            onMovieTap: { movie in
                
                viewModel.didTapMovie(movie)
            
                Task {
                    await viewModel.addRecentlyViewed(movie: movie)
                }
                
            }, onWatchlistTap: { movie in
                
                Task {
                    await viewModel.toggleWatchlist(for: movie)
                }
                
            }, onActorTap: { actor in
                
                viewModel.didTapActor(actor)
            
                Task {
                    await viewModel.addRecentlyViewed(actor: actor)
                }
                
            }, onFavouriteTap: { actor in
            
                Task {
                    await viewModel.toggleFavourite(for: actor)
                }
                
            }, onSeeAllTap: {
                
                viewModel.didTapSeeAll(.recentlyViewed)
                
            }, onClearHistory: {
                Task {
                    await viewModel.clearRecentlyViewed()
                }
            }
        )
    }
    
    // MARK: - Follow us
    
    private var footer: some View {
        
        HomeFooterView()
        
    }

}

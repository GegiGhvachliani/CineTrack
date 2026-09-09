import DesignSystemComponents
import DesignSystemTokens
import HomePresentation
import SharedCore
import SwiftUI

public struct ProfileView: View {
    @State private var viewModel: ProfileViewModel

    public init(viewModel: ProfileViewModel) { self.viewModel = viewModel }

    // MARK: - Body

    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                header
                if viewModel.isLoading && !viewModel.hasLoaded {
                    ProgressView().tint(ColorTokens.Brand.primary).padding(40)
                } else if viewModel.hasLoaded {
                    recentlyViewedSection
                    favouritesSection
                    watchlistSection
                } else {
                    Button("Try Again") { Task { await viewModel.load() } }
                        .tint(ColorTokens.Brand.primary)
                }
            }
            .padding(.bottom, 32)
        }
        .background(Color.black)
        .scrollIndicators(.hidden)
        .toolbar(.hidden, for: .navigationBar)
        .task { await viewModel.load() }
        .refreshable { await viewModel.load() }
        .alert(
            "Something went wrong",
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )
        ) {
            Button("OK") { viewModel.errorMessage = nil }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }

    // MARK: - Header

    private var header: some View {
        ProfileHeaderView(
            account: viewModel.account,
            isUpdatingPhoto: viewModel.isUpdatingPhoto,
            isSigningOut: viewModel.isSigningOut,
            onPhotoSelected: viewModel.savePhoto,
            onPhotoError: { viewModel.errorMessage = $0 },
            onSignOut: {
                Task { await viewModel.signOut() }
            }
        )
    }

    // MARK: - Recently Viewed

    private var recentlyViewedSection: some View {
        RecentlyViewedSectionView(
            items: viewModel.recentlyViewed,
            watchlistedMovies: viewModel.movies,
            favouritedActors: viewModel.actors,
            onMovieTap: { viewModel.onMovieTap?($0) },
            onWatchlistTap: { movie in
                Task { await viewModel.toggleWatchlist(movie) }
            },
            onActorTap: { viewModel.onActorTap?($0.id) },
            onFavouriteTap: { actor in
                Task { await viewModel.toggleFavourite(actor) }
            },
            onSeeAllTap: viewModel.showHistory,
            onClearHistory: {
                Task { await viewModel.clearHistory() }
            }
        )
    }

    // MARK: - Favourited

    @ViewBuilder
    private var favouritesSection: some View {
        if viewModel.actors.isEmpty {
            ProfileEmptySectionView(
                title: "Favourited",
                message: "Your favourite people will appear here.",
                detail: "Tap the heart on a person's card to add them to your favourites."
            )
        } else {
            HorizontalScrollView(
                headerText: "Favourited",
                seeAllTitle: "See All",
                items: viewModel.actors,
                onSeeAllTap: {
                    viewModel.onSeeAll?(
                        SeeAllContent(title: "Favourited", payload: .actors(viewModel.actors))
                    )
                }
            ) { actor, _ in
                MovieActorCell(
                    actor: actor,
                    cellHeight: 240,
                    isFavourited: true,
                    onActorTap: { viewModel.onActorTap?(actor.id) },
                    onFavouriteTap: {
                        Task { await viewModel.toggleFavourite(actor) }
                    }
                )
            }
        }
    }

    // MARK: - Watchlisted

    @ViewBuilder
    private var watchlistSection: some View {
        if viewModel.movies.isEmpty {
            ProfileEmptySectionView(
                title: "Watchlisted",
                message: "Your watchlist is waiting for its first movie.",
                detail: "Tap the bookmark on a movie to save it for later."
            )
        } else {
            WatchlistedMoviesSesctionView(
                title: "Watchlisted",
                movies: viewModel.movies,
                watchlistedMovies: viewModel.movies,
                onMovieTap: { viewModel.onMovieTap?($0) },
                onWatchlistTap: { movie in
                    Task { await viewModel.toggleWatchlist(movie) }
                },
                onSeeAllTap: {
                    viewModel.onSeeAll?(
                        SeeAllContent(title: "Watchlisted", payload: .movies(viewModel.movies))
                    )
                },
                onLoadMore: {}
            )
        }
    }
}

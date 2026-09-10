import DesignSystemComponents
import LibraryDomain
import DesignSystemTokens
import SharedCore
import SwiftUI

public struct ProfileView<ViewModel: ProfileViewModelProtocol>: View {

    // MARK: - Properties

    @State
    private var viewModel: ViewModel

    // MARK: - Initialization

    public init(viewModel: ViewModel) { self.viewModel = viewModel }

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
                    Button(ProfileStrings.Content.tryAgain) { Task { await viewModel.load() } }
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
            ProfileStrings.Content.somethingWentWrong,
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )
        ) {
            Button(ProfileStrings.Content.okay) { viewModel.errorMessage = nil }
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
            onMovieTap: viewModel.didTapMovie,
            onWatchlistTap: { movie in
                Task { await viewModel.toggleWatchlist(movie) }
            },
            onActorTap: viewModel.didTapActor,
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
        ProfileFavouritesSectionView(
            actors: viewModel.actors,
            onActorTap: viewModel.didTapActor,
            onFavouriteTap: { actor in
                Task { await viewModel.toggleFavourite(actor) }
            },
            onSeeAllTap: viewModel.showFavourites
        )
    }

    // MARK: - Watchlisted

    @ViewBuilder
    private var watchlistSection: some View {
        ProfileWatchlistSectionView(
            movies: viewModel.movies,
            onMovieTap: viewModel.didTapMovie,
            onWatchlistTap: { movie in
                Task { await viewModel.toggleWatchlist(movie) }
            },
            onSeeAllTap: viewModel.showWatchlist
        )
    }
}

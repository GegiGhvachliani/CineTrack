//
//  SearchView.swift
//  Search
//

import SwiftUI
import LibraryDomain

import DesignSystemTokens
import SearchDomain

public struct SearchView<ViewModel: SearchViewModelProtocol>: View {

    // MARK: - ViewModel

    @State
    private var viewModel: ViewModel

    // MARK: - Initialization

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    public var body: some View {
        @Bindable
        var viewModel = viewModel

        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 10) {
                    searchHeader(viewModel: viewModel)
                    modeSwitcher(viewModel: viewModel)

                    if viewModel.selectedMode == .recent {
                        targetSwitcher(viewModel: viewModel)
                    } else {
                        advancedFilters(viewModel: viewModel)
                        seeResultsButton
                    }

                    searchResults(viewModel: viewModel)
                }
                .padding(.horizontal, 8)
                .padding(.top, 50)
                .padding(.bottom, 32)
            }
            .scrollIndicators(.hidden)
        }
        .task {
            await viewModel.loadPersonalization()
        }
    }

    // MARK: - Header

    private func searchHeader(viewModel: ViewModel) -> some View {
        SearchHeaderSectionView(
            searchQuery: Binding(
                get: { viewModel.searchQuery },
                set: { viewModel.searchQuery = $0 }
            ),
            selectedMode: viewModel.selectedMode,
            selectedTarget: viewModel.selectedTarget
        )
    }

    // MARK: - Switchers

    private func modeSwitcher(viewModel: ViewModel) -> some View {
        SearchModeSectionView(
            selectedMode: Binding(
                get: { viewModel.selectedMode },
                set: { viewModel.selectedMode = $0 }
            )
        )
    }

    private func targetSwitcher(viewModel: ViewModel) -> some View {
        SearchTargetSectionView(
            selectedTarget: Binding(
                get: { viewModel.selectedTarget },
                set: { viewModel.selectedTarget = $0 }
            )
        )
    }

    // MARK: - Advanced filters

    private func advancedFilters(viewModel: ViewModel) -> some View {
        AdvancedSearchFiltersSectionView(
            filters: Binding(
                get: { viewModel.advancedFilters },
                set: { viewModel.advancedFilters = $0 }
            ),
            onReset: viewModel.resetAdvancedOptions
        )
    }

    private var seeResultsButton: some View {
        Button {
            Task {
                await viewModel.searchAdvancedMovies()
            }
        } label: {
            Text(SearchStrings.Content.seeResults)
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .foregroundStyle(ColorTokens.Text.inverse)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(ColorTokens.Brand.primary)
                .clipShape(Capsule())
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    // MARK: - Results

    private func searchResults(viewModel: ViewModel) -> some View {
        SearchResultsSectionView(
            movies: viewModel.movies,
            actors: viewModel.actors,
            isLoading: viewModel.isLoading,
            isLoadingMore: viewModel.isLoadingMore,
            hasMoreResults: viewModel.hasMoreResults,
            errorMessage: viewModel.errorMessage,
            hasSearched: viewModel.hasSearched,
            selectedMode: viewModel.selectedMode,
            watchlistedMovieIDs: viewModel.watchlistedMovieIDs,
            favouritedActorIDs: viewModel.favouritedActorIDs,
            onLoadMore: { Task { await viewModel.loadNextResultsPage() } },
            onMovieTap: viewModel.didTapMovie,
            onActorTap: viewModel.didTapActor,
            onWatchlistTap: { movie in
                Task {
                    await viewModel.toggleWatchlist(for: movie)
                }
            },
            onFavouriteTap: { actor in
                Task {
                    await viewModel.toggleFavourite(for: actor)
                }
            }
        )
    }
}

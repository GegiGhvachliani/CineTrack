//
//  SearchViewModel.swift
//  Search
//

import Combine
import Foundation
import Observation

import LibraryDomain
import SearchDomain
import SharedCore

@Observable
@MainActor
public final class SearchViewModel: SearchViewModelProtocol {

    // MARK: - Navigation

    public var onMovieDetails: ((Movie) -> Void)?
    public var onActorDetails: ((Int) -> Void)?

    // MARK: - Search state

    public var selectedMode: SearchMode = .recent {
        didSet {
            clearResults()

            if selectedMode == .advanced {
                searchQuery = ""
            } else {
                sendSearchRequest()
            }
        }
    }

    public var selectedTarget: SearchTarget = .movies {
        didSet {
            clearResults()
            sendSearchRequest()
        }
    }

    public var searchQuery = "" {
        didSet { sendSearchRequest() }
    }

    public var advancedFilters = SearchFilters()

    // MARK: - Results

    public internal(set) var movies: [Movie] = []
    public internal(set) var actors: [Actor] = []
    public internal(set) var isLoading = false
    public internal(set) var isLoadingMore = false
    public internal(set) var hasMoreResults = false
    public internal(set) var errorMessage: String?
    public internal(set) var hasSearched = false
    public internal(set) var watchlistedMovieIDs = Set<Int>()
    public internal(set) var favouritedActorIDs = Set<Int>()

    // MARK: - Dependencies

    internal let searchMoviesUseCase: SearchMoviesUseCaseProtocol
    internal let searchActorsUseCase: SearchActorsUseCaseProtocol
    internal let discoverMoviesUseCase: DiscoverMoviesUseCaseProtocol
    internal let fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol
    internal let addWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol
    internal let removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol
    internal let fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol
    internal let addFavouritedActorUseCase: AddFavouritedActorUseCaseProtocol
    internal let removeFavouritedActorUseCase: RemoveFavouritedActorUseCaseProtocol

    internal var pendingWatchlistIDs = Set<Int>()
    internal var pendingFavouriteIDs = Set<Int>()

    // MARK: - Combine

    internal let searchRequestSubject = PassthroughSubject<TextSearchRequest, Never>()
    internal var cancellables = Set<AnyCancellable>()
    internal var searchTask: Task<Void, Never>?
    internal var searchGeneration = UUID()
    internal var nextResultsPage = 2
    internal var activeSearchRequest: SearchRequest?

    // MARK: - Initialization

    public init(
        searchMoviesUseCase: SearchMoviesUseCaseProtocol,
        searchActorsUseCase: SearchActorsUseCaseProtocol,
        discoverMoviesUseCase: DiscoverMoviesUseCaseProtocol,
        fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCaseProtocol,
        addWatchlistedMovieUseCase: AddWatchlistedMovieUseCaseProtocol,
        removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCaseProtocol,
        fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCaseProtocol,
        addFavouritedActorUseCase: AddFavouritedActorUseCaseProtocol,
        removeFavouritedActorUseCase: RemoveFavouritedActorUseCaseProtocol
    ) {
        self.searchMoviesUseCase = searchMoviesUseCase
        self.searchActorsUseCase = searchActorsUseCase
        self.discoverMoviesUseCase = discoverMoviesUseCase
        self.fetchWatchlistedMoviesUseCase = fetchWatchlistedMoviesUseCase
        self.addWatchlistedMovieUseCase = addWatchlistedMovieUseCase
        self.removeWatchlistedMovieUseCase = removeWatchlistedMovieUseCase
        self.fetchFavouritedActorsUseCase = fetchFavouritedActorsUseCase
        self.addFavouritedActorUseCase = addFavouritedActorUseCase
        self.removeFavouritedActorUseCase = removeFavouritedActorUseCase

        bindSearchQuery()
    }

    // MARK: - Private

    internal static let resultsPerPage = 20
}

// MARK: - Text search request

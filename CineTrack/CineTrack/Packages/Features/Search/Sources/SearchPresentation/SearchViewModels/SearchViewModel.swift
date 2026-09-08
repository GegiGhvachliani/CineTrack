//
//  SearchViewModel.swift
//  Search
//

import Combine
import Foundation
import Observation

import SearchDomain
import SharedCore

@Observable
@MainActor
public final class SearchViewModel {

    // MARK: - Navigation

    public var onMovieDetails: ((Movie) -> Void)?
    public var onActorDetails: ((Int) -> Void)?

    // MARK: - Search state

    public var selectedMode: SearchMode = .recent {
        didSet {
            clearResults()

            if selectedMode == .advanced {
                searchQuery = ""
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

    // MARK: - Dependencies

    private let searchMoviesUseCase: SearchMoviesUseCaseProtocol
    private let searchActorsUseCase: SearchActorsUseCaseProtocol
    private let discoverMoviesUseCase: DiscoverMoviesUseCaseProtocol

    // MARK: - Combine

    private let searchRequestSubject = PassthroughSubject<TextSearchRequest, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var searchTask: Task<Void, Never>?
    private var nextResultsPage = 2
    private var activeSearchRequest: SearchRequest?

    // MARK: - Initialization

    public init(
        searchMoviesUseCase: SearchMoviesUseCaseProtocol,
        searchActorsUseCase: SearchActorsUseCaseProtocol,
        discoverMoviesUseCase: DiscoverMoviesUseCaseProtocol
    ) {
        self.searchMoviesUseCase = searchMoviesUseCase
        self.searchActorsUseCase = searchActorsUseCase
        self.discoverMoviesUseCase = discoverMoviesUseCase

        bindSearchQuery()
    }

    // MARK: - Actions

    public func searchAdvancedMovies() async {
        isLoading = true
        errorMessage = nil
        hasSearched = true

        defer { isLoading = false }

        do {
            let filters = advancedFilters
            let foundMovies = try await discoverMoviesUseCase.execute(filters: filters, page: 1)

            replaceResults(
                movies: foundMovies,
                request: .advanced(filters)
            )
            actors = []
        } catch {
            print("❌ Advanced Search Error:", error)
            errorMessage = "We couldn't load results. Please try again."
        }
    }

    public func didTapMovie(_ movie: Movie) {
        onMovieDetails?(movie)
    }

    public func didTapActor(_ actor: Actor) {
        onActorDetails?(actor.id)
    }

    public func resetAdvancedOptions() {
        advancedFilters = SearchFilters()
        clearResults()
    }

    // MARK: - Pagination

    public func loadNextResultsPage() async {
        guard !isLoadingMore, hasMoreResults, let activeSearchRequest else {
            return
        }

        isLoadingMore = true
        defer { isLoadingMore = false }

        do {
            let page = nextResultsPage

            switch activeSearchRequest {
            case .movies(let query):
                let nextMovies = try await searchMoviesUseCase.execute(query: query, page: page)

                guard self.activeSearchRequest == activeSearchRequest else { return }

                movies.append(contentsOf: nextMovies)
                updatePagination(with: nextMovies.count)

            case .actors(let query):
                let nextActors = try await searchActorsUseCase.execute(query: query, page: page)

                guard self.activeSearchRequest == activeSearchRequest else { return }

                actors.append(contentsOf: nextActors)
                updateActorPagination(with: nextActors.count)

            case .advanced(let filters):
                let nextMovies = try await discoverMoviesUseCase.execute(filters: filters, page: page)

                guard self.activeSearchRequest == activeSearchRequest else { return }

                movies.append(contentsOf: nextMovies)
                updatePagination(with: nextMovies.count)
            }
        } catch {
            print("❌ Search Pagination Error:", error)
        }
    }

    // MARK: - Private

    private func bindSearchQuery() {
        searchRequestSubject
            .removeDuplicates()
            .debounce(for: .milliseconds(350), scheduler: RunLoop.main)
            .sink { [weak self] request in
                guard let self else { return }

                self.searchTask?.cancel()

                self.searchTask = Task { @MainActor [weak self] in
                    await self?.searchByName(
                        query: request.query,
                        target: request.target
                    )
                }
            }
            .store(in: &cancellables)
    }

    private func searchByName(query: String, target: SearchTarget) async {
        guard selectedMode == .recent else { return }

        guard !query.isEmpty else {
            clearResults()
            return
        }

        isLoading = true
        errorMessage = nil
        hasSearched = true

        defer { isLoading = false }

        do {
            switch target {
            case .movies:
                let foundMovies = try await searchMoviesUseCase.execute(query: query, page: 1)

                guard !Task.isCancelled, selectedTarget == target else { return }

                replaceResults(movies: foundMovies, request: .movies(query))
                actors = []

            case .people:
                let foundActors = try await searchActorsUseCase.execute(query: query, page: 1)

                guard !Task.isCancelled, selectedTarget == target else { return }

                replaceResults(actors: foundActors, request: .actors(query))
                movies = []
            }
        } catch {
            print("❌ Search Error:", error)
            errorMessage = "We couldn't load results. Please try again."
        }
    }

    private func clearResults() {
        movies = []
        actors = []
        hasSearched = false
        errorMessage = nil
        hasMoreResults = false
        nextResultsPage = 2
        activeSearchRequest = nil
    }

    private func sendSearchRequest() {
        searchRequestSubject.send(
            TextSearchRequest(
                query: searchQuery.trimmingCharacters(in: .whitespacesAndNewlines),
                target: selectedTarget
            )
        )
    }

    private func replaceResults(movies: [Movie], request: SearchRequest) {
        self.movies = movies
        activeSearchRequest = request
        nextResultsPage = 2
        hasMoreResults = movies.count == Self.resultsPerPage
    }

    private func replaceResults(actors: [Actor], request: SearchRequest) {
        self.actors = actors
        activeSearchRequest = request
        nextResultsPage = 2
        hasMoreResults = !actors.isEmpty
    }

    private func updatePagination(with resultCount: Int) {
        nextResultsPage += 1
        hasMoreResults = resultCount == Self.resultsPerPage
    }

    private func updateActorPagination(with resultCount: Int) {
        nextResultsPage += 1
        hasMoreResults = resultCount > 0
    }

    private static let resultsPerPage = 20
}

// MARK: - Text search request

private struct TextSearchRequest: Equatable {
    let query: String
    let target: SearchTarget
}

private enum SearchRequest: Equatable {
    case movies(String)
    case actors(String)
    case advanced(SearchFilters)
}

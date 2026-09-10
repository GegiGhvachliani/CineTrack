//
//  SearchViewModel+Search.swift
//  Search
//

import Combine
import Foundation
import Observation
import LibraryDomain
import SearchDomain
import SharedCore

extension SearchViewModel {

    // MARK: - Search

    public func searchAdvancedMovies() async {
        guard selectedMode == .advanced else {
            return
        }

        clearResults()
        let generation = searchGeneration
        isLoading = true
        errorMessage = nil
        hasSearched = true

        defer {
            if searchGeneration == generation {
                isLoading = false
            }
        }

        do {
            let filters = advancedFilters
            let foundMovies = try await discoverMoviesUseCase.execute(filters: filters, page: 1)

            guard !Task.isCancelled, searchGeneration == generation, selectedMode == .advanced else {
                return
            }

            replaceResults(
                movies: foundMovies,
                request: .advanced(filters)
            )
            actors = []
        } catch is CancellationError {
            return
        } catch {
            guard searchGeneration == generation else {
                return
            }
            errorMessage = SearchStrings.Content.resultsUnavailable
        }
    }

    internal func bindSearchQuery() {
        searchRequestSubject
            .debounce(for: .milliseconds(350), scheduler: RunLoop.main)
            .sink { [weak self] request in
                guard let self, self.searchGeneration == request.generation else { return }

                self.searchTask?.cancel()

                self.searchTask = Task { @MainActor [weak self] in
                    await self?.searchByName(
                        query: request.query,
                        target: request.target,
                        generation: request.generation
                    )
                }
            }
            .store(in: &cancellables)
    }

    internal func searchByName(query: String, target: SearchTarget, generation: UUID) async {
        guard selectedMode == .recent, searchGeneration == generation else { return }

        guard !query.isEmpty else {
            clearResults()
            return
        }

        isLoading = true
        errorMessage = nil
        hasSearched = true

        defer {
            if searchGeneration == generation {
                isLoading = false
            }
        }

        do {
            switch target {
            case .movies:
                let foundMovies = try await searchMoviesUseCase.execute(query: query, page: 1)

                guard !Task.isCancelled, searchGeneration == generation, selectedMode == .recent,
                    selectedTarget == target
                else { return }

                replaceResults(movies: foundMovies, request: .movies(query))
                actors = []

            case .people:
                let foundActors = try await searchActorsUseCase.execute(query: query, page: 1)

                guard !Task.isCancelled, searchGeneration == generation, selectedMode == .recent,
                    selectedTarget == target
                else { return }

                replaceResults(actors: foundActors, request: .actors(query))
                movies = []
            }
        } catch is CancellationError {
            return
        } catch {
            guard searchGeneration == generation else {
                return
            }
            errorMessage = SearchStrings.Content.resultsUnavailable
        }
    }

    internal func clearResults() {
        searchTask?.cancel()
        searchGeneration = UUID()
        isLoading = false
        isLoadingMore = false
        movies = []
        actors = []
        hasSearched = false
        errorMessage = nil
        hasMoreResults = false
        nextResultsPage = 2
        activeSearchRequest = nil
    }

    internal func sendSearchRequest() {
        clearResults()

        guard selectedMode == .recent else {
            return
        }

        searchRequestSubject.send(
            TextSearchRequest(
                query: searchQuery.trimmingCharacters(in: .whitespacesAndNewlines),
                target: selectedTarget,
                generation: searchGeneration
            )
        )
    }

    internal func replaceResults(movies: [Movie], request: SearchRequest) {
        self.movies = movies
        activeSearchRequest = request
        nextResultsPage = 2
        hasMoreResults = movies.count == Self.resultsPerPage
    }

    internal func replaceResults(actors: [Actor], request: SearchRequest) {
        self.actors = actors
        activeSearchRequest = request
        nextResultsPage = 2
        hasMoreResults = !actors.isEmpty
    }
}

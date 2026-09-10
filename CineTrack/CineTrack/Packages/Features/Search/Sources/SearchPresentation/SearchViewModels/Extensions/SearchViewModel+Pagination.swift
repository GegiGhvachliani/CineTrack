import Combine
import Foundation
import Observation
import LibraryDomain
import SearchDomain
import SharedCore

extension SearchViewModel {

    // MARK: - Pagination

    public func loadNextResultsPage() async {
        guard !isLoading, !isLoadingMore, hasMoreResults, let activeSearchRequest else {
            return
        }

        let generation = searchGeneration
        isLoadingMore = true
        defer {
            if searchGeneration == generation {
                isLoadingMore = false
            }
        }

        do {
            let page = nextResultsPage

            switch activeSearchRequest {
            case .movies(let query):
                let nextMovies = try await searchMoviesUseCase.execute(query: query, page: page)

                guard !Task.isCancelled, searchGeneration == generation, self.activeSearchRequest == activeSearchRequest
                else { return }

                var existingIDs = Set(movies.map(\.id))
                movies.append(contentsOf: nextMovies.filter { existingIDs.insert($0.id).inserted })
                updatePagination(with: nextMovies.count)

            case .actors(let query):
                let nextActors = try await searchActorsUseCase.execute(query: query, page: page)

                guard !Task.isCancelled, searchGeneration == generation, self.activeSearchRequest == activeSearchRequest
                else { return }

                var existingIDs = Set(actors.map(\.id))
                actors.append(contentsOf: nextActors.filter { existingIDs.insert($0.id).inserted })
                updateActorPagination(with: nextActors.count)

            case .advanced(let filters):
                let nextMovies = try await discoverMoviesUseCase.execute(filters: filters, page: page)

                guard !Task.isCancelled, searchGeneration == generation, self.activeSearchRequest == activeSearchRequest
                else { return }

                var existingIDs = Set(movies.map(\.id))
                movies.append(contentsOf: nextMovies.filter { existingIDs.insert($0.id).inserted })
                updatePagination(with: nextMovies.count)
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

    internal func updatePagination(with resultCount: Int) {
        nextResultsPage += 1
        hasMoreResults = resultCount == Self.resultsPerPage
    }

    internal func updateActorPagination(with resultCount: Int) {
        nextResultsPage += 1
        hasMoreResults = resultCount > 0
    }
}

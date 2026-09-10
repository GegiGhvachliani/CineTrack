//
//  SearchViewModel+Actions.swift
//  Search
//

import Combine
import Foundation
import Observation
import LibraryDomain
import SearchDomain
import SharedCore

extension SearchViewModel {

    // MARK: - Actions

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
}

//
//  SearchTarget.swift
//  Search
//

import SearchDomain

extension SearchTarget {

    // MARK: - Properties

    var title: String {
        switch self {
        case .movies:
            SearchStrings.Content.movie
        case .people:
            SearchStrings.Content.actor
        }
    }
}

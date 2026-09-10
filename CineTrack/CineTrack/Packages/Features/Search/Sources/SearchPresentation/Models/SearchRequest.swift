//
//  SearchRequest.swift
//  Search
//

import Foundation
import SearchDomain

enum SearchRequest: Equatable {
    case movies(String)
    case actors(String)
    case advanced(SearchFilters)
}

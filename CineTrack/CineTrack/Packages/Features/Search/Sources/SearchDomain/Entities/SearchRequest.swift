//
//  SearchRequest.swift
//  Search
//

import Foundation

enum SearchRequest: Equatable {
    case movies(String)
    case actors(String)
    case advanced(SearchFilters)
}

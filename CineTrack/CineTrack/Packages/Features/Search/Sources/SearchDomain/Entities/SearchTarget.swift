//
//  SearchTarget.swift
//  Search
//

import Foundation

public enum SearchTarget: String, CaseIterable, Identifiable, Sendable {

    case movies = "Movie"
    case people = "Actor"

    public var id: Self { self }
}

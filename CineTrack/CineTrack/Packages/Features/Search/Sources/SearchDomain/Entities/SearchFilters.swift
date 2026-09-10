//
//  SearchFilters.swift
//  Search
//

import Foundation

public struct SearchFilters: Sendable, Equatable {

    // MARK: - Properties

    public var minimumRating: Int?
    public var minimumVoteCount: Int?
    public var genreIDs: [Int]
    public var minimumReleaseYear: Int?
    public var maximumReleaseYear: Int?
    public var minimumRuntime: Int?
    public var maximumRuntime: Int?
    public var originCountryCodes: [String]

    // MARK: - Initialization

    public init(
        minimumRating: Int? = nil,
        minimumVoteCount: Int? = nil,
        genreIDs: [Int] = [],
        minimumReleaseYear: Int? = nil,
        maximumReleaseYear: Int? = nil,
        minimumRuntime: Int? = nil,
        maximumRuntime: Int? = nil,
        originCountryCodes: [String] = []
    ) {
        self.minimumRating = minimumRating
        self.minimumVoteCount = minimumVoteCount
        self.genreIDs = genreIDs
        self.minimumReleaseYear = minimumReleaseYear
        self.maximumReleaseYear = maximumReleaseYear
        self.minimumRuntime = minimumRuntime
        self.maximumRuntime = maximumRuntime
        self.originCountryCodes = originCountryCodes
    }
}

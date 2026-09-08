import Foundation

public struct SearchFilters: Sendable, Equatable {
    public var minimumRating: Int?
    public var minimumVoteCount: Int?
    public var genreIDs: [Int]
    public var releaseYear: Int?
    public var minimumRuntime: Int?
    public var maximumRuntime: Int?
    public var region: String?

    public init(minimumRating: Int? = nil, minimumVoteCount: Int? = nil, genreIDs: [Int] = [], releaseYear: Int? = nil, minimumRuntime: Int? = nil, maximumRuntime: Int? = nil, region: String? = nil) {
        self.minimumRating = minimumRating
        self.minimumVoteCount = minimumVoteCount
        self.genreIDs = genreIDs
        self.releaseYear = releaseYear
        self.minimumRuntime = minimumRuntime
        self.maximumRuntime = maximumRuntime
        self.region = region
    }
}

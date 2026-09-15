import SharedCore

public struct SimilarMoviesPage: Sendable {

    public let movies: [Movie]
    public let page: Int
    public let totalPages: Int

    public var hasNextPage: Bool {
        page < totalPages
    }

    public init(movies: [Movie], page: Int, totalPages: Int) {
        self.movies = movies
        self.page = page
        self.totalPages = totalPages
    }
}

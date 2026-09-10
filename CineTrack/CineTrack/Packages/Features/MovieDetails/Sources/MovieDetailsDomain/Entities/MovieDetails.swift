import Foundation
import SharedCore

public struct MovieDetails: Identifiable, Equatable, Sendable {

    // MARK: - Properties

    public let id: Int
    public let title: String
    public let overview: String
    public let posterPath: String?
    public let backdropPath: String?
    public let releaseDate: String?
    public let runtime: Int?
    public let genres: [String]
    public let homepage: String?
    public let status: String?
    public let tagline: String?
    public let voteAverage: Double
    public let voteCount: Int

    // MARK: - Initialization

    public init(
        id: Int,
        title: String,
        overview: String,
        posterPath: String?,
        backdropPath: String?,
        releaseDate: String?,
        runtime: Int?,
        genres: [String],
        homepage: String?,
        status: String?,
        tagline: String?,
        voteAverage: Double,
        voteCount: Int
    ) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
        self.runtime = runtime
        self.genres = genres
        self.homepage = homepage
        self.status = status
        self.tagline = tagline
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }

    public var movie: Movie {
        Movie(
            id: id,
            title: title,
            overview: overview,
            posterPath: posterPath,
            backdropPath: backdropPath,
            releaseDate: releaseDate,
            voteAverage: voteAverage,
            voteCount: voteCount
        )
    }
}

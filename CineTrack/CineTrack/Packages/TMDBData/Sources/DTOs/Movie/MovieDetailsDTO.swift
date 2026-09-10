import Foundation

public struct MovieDetailsDTO: Decodable {

    // MARK: - Properties

    public let id: Int
    public let title: String
    public let overview: String?
    public let posterPath: String?
    public let backdropPath: String?
    public let releaseDate: String?
    public let runtime: Int?
    public let genres: [MovieGenreDTO]
    public let homepage: String?
    public let status: String?
    public let tagline: String?
    public let voteAverage: Double
    public let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case runtime
        case genres
        case homepage
        case status
        case tagline
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

public struct MovieGenreDTO: Decodable {

    // MARK: - Properties

    public let id: Int
    public let name: String
}

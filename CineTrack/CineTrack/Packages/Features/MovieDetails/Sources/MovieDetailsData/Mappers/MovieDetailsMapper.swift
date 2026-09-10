import MovieDetailsDomain
import TMDBData

struct MovieDetailsMapper: Sendable {

    // MARK: - Properties

    private let imageBaseURL = "https://image.tmdb.org/t/p/w780"

    func map(_ dto: MovieDetailsDTO) -> MovieDetails {
        MovieDetails(
            id: dto.id,
            title: dto.title,
            overview: dto.overview ?? "",
            posterPath: imageURL(from: dto.posterPath),
            backdropPath: imageURL(from: dto.backdropPath),
            releaseDate: dto.releaseDate,
            runtime: dto.runtime,
            genres: dto.genres.map(\.name),
            homepage: dto.homepage,
            status: dto.status,
            tagline: dto.tagline,
            voteAverage: dto.voteAverage,
            voteCount: dto.voteCount
        )
    }

    private func imageURL(from path: String?) -> String? {
        guard let path, !path.isEmpty else {
            return nil
        }

        if path.hasPrefix("http") {
            return path
        }

        return "\(imageBaseURL)\(path)"
    }
}

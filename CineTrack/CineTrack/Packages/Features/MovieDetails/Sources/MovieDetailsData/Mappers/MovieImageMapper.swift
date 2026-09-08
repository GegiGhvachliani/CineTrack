import Foundation
import MovieDetailsDomain
import TMDBData

struct MovieImageMapper: Sendable {
    private let imageBaseURL = "https://image.tmdb.org/t/p/w780"

    func map(_ dto: MovieImageDTO) -> MovieImage? {
        guard let url = URL(string: "\(imageBaseURL)\(dto.filePath)") else {
            return nil
        }

        return MovieImage(
            id: dto.filePath,
            url: url,
            aspectRatio: dto.aspectRatio
        )
    }
}

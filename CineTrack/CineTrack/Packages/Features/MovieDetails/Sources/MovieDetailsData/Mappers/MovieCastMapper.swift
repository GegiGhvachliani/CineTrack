import Foundation
import MovieDetailsDomain
import TMDBData

struct MovieCastMapper: Sendable {
    private let imageBaseURL = "https://image.tmdb.org/t/p/w500"

    func map(_ dto: MovieCastDTO) -> MovieCastMember {
        MovieCastMember(
            id: dto.id,
            creditID: dto.creditID,
            name: dto.name,
            character: dto.character,
            profilePath: dto.profilePath,
            profileURL: makeImageURL(from: dto.profilePath),
            order: dto.order
        )
    }

    private func makeImageURL(from path: String?) -> URL? {
        guard let path, !path.isEmpty else {
            return nil
        }

        if path.hasPrefix("http") {
            return URL(string: path)
        }

        return URL(string: "\(imageBaseURL)\(path)")
    }
}

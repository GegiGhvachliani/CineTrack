import Foundation
import LibraryDomain
import Observation
import ActorDetailsDomain
import ActorMediaDomain
import ActorVideosDomain
import SharedCore

extension ActorDetailsViewModel {

    // MARK: - Actions

    public func didTapCredit(
        _ credit: ActorCredit
    ) {
        onMovieDetails?(
            Movie(
                id: credit.id,
                title: credit.title,
                overview: credit.overview,
                posterPath: credit.posterPath,
                backdropPath: credit.backdropPath,
                releaseDate: credit.releaseDate,
                voteAverage: credit.voteAverage,
                voteCount: credit.voteCount
            )
        )
    }

    public func didTapNews(
        _ news: News
    ) {
        onNewsDetails?(news)
    }

    public func didTapVideo(_ actorVideo: ActorVideo) {
        guard let credit = credits.first(where: { $0.id == actorVideo.movieID }) else {
            return
        }

        let movie = Movie(
            id: credit.id,
            title: credit.title,
            overview: credit.overview,
            posterPath: credit.posterURL?.absoluteString ?? credit.posterPath,
            backdropPath: credit.backdropURL?.absoluteString ?? credit.backdropPath,
            releaseDate: credit.releaseDate,
            voteAverage: credit.voteAverage,
            voteCount: credit.voteCount
        )
        onShowVideos?(
            VideoPlaylistContext(
                movie: movie,
                selectedVideo: actorVideo.video,
                source: .actorDetails
            )
        )
    }

    public func didTapMiniBiography() {
        guard let actor else {
            return
        }
        onShowMiniBiography?(actor)
    }

    public func didTapSeeAllFilmography() {
        let movies = filmography.map {
            Movie(
                id: $0.id,
                title: $0.title,
                overview: $0.overview,
                posterPath: $0.posterURL?.absoluteString ?? $0.posterPath,
                backdropPath: $0.backdropURL?.absoluteString ?? $0.backdropPath,
                releaseDate: $0.releaseDate,
                voteAverage: $0.voteAverage,
                voteCount: $0.voteCount
            )
        }
        onShowSeeAll?(SeeAllContent(title: ActorDetailsStrings.Content.filmography, payload: .movies(movies)))
    }

    public func didTapSeeAllImages() {
        let images = mediaImages.map {
            GalleryImage(id: $0.id, url: $0.url, aspectRatio: $0.aspectRatio)
        }
        onShowSeeAll?(SeeAllContent(title: ActorDetailsStrings.Content.images, payload: .images(images)))
    }

    public func didTapSeeAllNews() {
        onShowSeeAll?(SeeAllContent(title: ActorDetailsStrings.Content.relatedNews, payload: .news(news)))
    }

    public func didTapExternalURL(
        _ url: URL
    ) {
        onOpenURL?(url)
    }
}

import Foundation
import LibraryDomain
import Observation
import MovieDetailsDomain
import SharedCore

extension MovieDetailsViewModel {

    // MARK: - Actions

    public func didTapMovie(_ movie: Movie) {
        onMovieDetails?(movie)
    }

    public func didTapActor(_ actor: MovieCastMember) {
        onActorDetails?(actor.id)
    }

    public func didTapNews(_ news: News) {
        onNewsDetails?(news)
    }

    public func didTapVideo(_ video: MovieVideo) {
        onShowVideos?(
            VideoPlaylistContext(
                movie: movie,
                selectedVideo: video,
                source: .movieDetails
            )
        )
    }

    public func didTapSeeAllCast() {
        let actors = cast.map {
            Actor(
                id: $0.id,
                name: $0.name,
                birthday: nil,
                profilePath: $0.profileURL?.absoluteString ?? $0.profilePath
            )
        }
        onShowSeeAll?(SeeAllContent(title: MovieDetailsStrings.Content.allCast, payload: .actors(actors)))
    }

    public func didTapSeeAllSimilarMovies() {
        onShowSeeAll?(SeeAllContent(title: MovieDetailsStrings.Content.moreLikeThis, payload: .movies(similarMovies)))
    }

    public func didTapSeeAllActorMovies() {
        let title = MovieDetailsStrings.Format.moreFrom(
            actorName: selectedActor?.name ?? MovieDetailsStrings.Content.actor)
        onShowSeeAll?(SeeAllContent(title: title, payload: .movies(selectedActorMovies)))
    }

    public func didTapSeeAllImages() {
        let galleryImages = images.map {
            GalleryImage(id: $0.id, url: $0.url, aspectRatio: $0.aspectRatio)
        }
        onShowSeeAll?(SeeAllContent(title: MovieDetailsStrings.Content.images, payload: .images(galleryImages)))
    }

    public func didTapSeeAllNews() {
        onShowSeeAll?(SeeAllContent(title: MovieDetailsStrings.Content.relatedNews, payload: .news(news)))
    }
}

import UIKit
import SharedCore

@MainActor
public protocol ActorDetailsRoutingProtocol: AnyObject {
    func showMovieDetails(movie: Movie)
    func showNewsDetails(news: News)
    func showSeeAll(content: SeeAllContent)
    func showVideosList(context: VideoPlaylistContext)
}

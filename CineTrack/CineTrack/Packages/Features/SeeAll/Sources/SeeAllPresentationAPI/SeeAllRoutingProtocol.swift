import SharedCore

@MainActor
public protocol SeeAllRoutingProtocol: AnyObject {
    func showMovieDetails(movie: Movie)
    func showActorDetails(actorID: Int)
    func showNewsDetails(news: News)
}

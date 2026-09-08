import SharedCore

@MainActor
public protocol MovieDetailsRoutingProtocol: AnyObject {
    func showMovieDetails(movie: Movie)
    func showActorDetails(actorID: Int)
    func showNewsDetails(news: News)
}

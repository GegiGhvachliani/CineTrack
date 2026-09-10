import SharedCore

public protocol SeeAllCoordinatorProtocol: Coordinator {

    var onFinish: (() -> Void)? { get set }

    func showMovieDetails(movie: Movie)
    func showActorDetails(actor: Actor)
    func showNewsDetails(news: News)
    func close()
}

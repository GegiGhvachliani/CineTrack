import Observation
import SeeAllDomain
import SharedCore

extension SeeAllViewModel {

    // MARK: - Actions

    public func close() {
        onClose?()
    }

    public func didTapMovie(_ movie: Movie) {
        onMovieTap?(movie)
    }

    public func didTapActor(_ actor: Actor) {
        onActorTap?(actor)
    }

    public func didTapNews(_ news: News) {
        onNewsTap?(news)
    }
}

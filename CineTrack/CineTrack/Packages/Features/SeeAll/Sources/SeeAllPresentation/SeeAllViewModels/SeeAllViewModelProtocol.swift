import Observation
import SharedCore

@MainActor
public protocol SeeAllViewModelProtocol: AnyObject, Observable {

    // MARK: - Content

    var title: String { get }
    var payload: SeeAllPayload { get }
    var isLoadingMore: Bool { get }

    // MARK: - Actions

    func close()

    func didTapMovie(_ movie: Movie)
    func didTapActor(_ actor: Actor)
    func didTapNews(_ news: News)
    func loadMoreIfNeeded(index: Int, count: Int) async
}

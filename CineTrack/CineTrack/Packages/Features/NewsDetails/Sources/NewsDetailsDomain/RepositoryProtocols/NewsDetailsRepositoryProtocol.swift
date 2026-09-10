import SharedCore

public protocol NewsDetailsRepositoryProtocol: Sendable {
    func fetchArticle() -> News
}

import NewsDetailsDomain
import SharedCore

public final class NewsDetailsRepository: NewsDetailsRepositoryProtocol {

    // MARK: - Content

    private let article: News

    // MARK: - Initialization

    public init(article: News) {
        self.article = article
    }

    // MARK: - Article

    public func fetchArticle() -> News {
        article
    }
}

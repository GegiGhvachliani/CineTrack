import Foundation
import Observation

public enum SeeAllPayload {
    case movies([Movie])
    case actors([Actor])
    case news([News])
    case images([GalleryImage])
    case library([SeeAllLibraryItem])
}

public enum SeeAllLibraryItem: Identifiable, Sendable {
    case movie(Movie)
    case actor(Actor)

    public var id: String {
        switch self {
        case .movie(let movie): "movie-\(movie.id)"
        case .actor(let actor): "actor-\(actor.id)"
        }
    }
}

public struct GalleryImage: Identifiable, Sendable, Equatable {
    public let id: String
    public let url: URL
    public let aspectRatio: Double

    public init(id: String, url: URL, aspectRatio: Double) {
        self.id = id
        self.url = url
        self.aspectRatio = aspectRatio
    }
}

@MainActor
@Observable
public final class SeeAllContent {
    public let title: String
    public private(set) var payload: SeeAllPayload
    public private(set) var isLoadingMore = false
    public private(set) var error: Error?

    private let hasMore: () -> Bool
    private let loadMore: (() async -> SeeAllPayload?)?

    public init(title: String, payload: SeeAllPayload, hasMore: @escaping () -> Bool = { false }, loadMore: (() async -> SeeAllPayload?)? = nil) {
        self.title = title
        self.payload = payload
        self.hasMore = hasMore
        self.loadMore = loadMore
    }

    public var canLoadMore: Bool { hasMore() }

    public func loadNextPage() async {
        guard canLoadMore, !isLoadingMore, let loadMore else { return }
        isLoadingMore = true
        error = nil
        defer { isLoadingMore = false }
        payload = await loadMore() ?? payload
    }
}

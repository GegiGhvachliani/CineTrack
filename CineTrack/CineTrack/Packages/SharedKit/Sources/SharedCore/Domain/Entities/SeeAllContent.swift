import Foundation

public enum SeeAllPayload: Sendable {
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

    // MARK: - Properties

    public let id: String
    public let url: URL
    public let aspectRatio: Double

    // MARK: - Initialization

    public init(id: String, url: URL, aspectRatio: Double) {
        self.id = id
        self.url = url
        self.aspectRatio = aspectRatio
    }
}

@MainActor
public struct SeeAllContent {

    // MARK: - Content

    public let title: String
    public let payload: SeeAllPayload

    // MARK: - Pagination Source

    public let hasMore: () -> Bool
    public let loadMore: (() async -> SeeAllPayload?)?

    // MARK: - Initialization

    public init(
        title: String,
        payload: SeeAllPayload,
        hasMore: @escaping () -> Bool = { false },
        loadMore: (() async -> SeeAllPayload?)? = nil
    ) {
        self.title = title
        self.payload = payload
        self.hasMore = hasMore
        self.loadMore = loadMore
    }
}

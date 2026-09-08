import Foundation
import Observation

public enum SeeAllPayload {
    case movies([Movie])
    case actors([Actor])
    case news([News])
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

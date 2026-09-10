import Observation
import SeeAllDomain
import SharedCore

extension SeeAllViewModel {

    // MARK: - Pagination

    public func loadMoreIfNeeded(index: Int, count: Int) async {
        guard count > 0, index >= count - 3, !isLoadingMore else {
            return
        }

        isLoadingMore = true
        defer { isLoadingMore = false }

        if let nextPayload = await fetchPageUseCase.execute(), !Task.isCancelled {
            payload = nextPayload
        }
    }
}

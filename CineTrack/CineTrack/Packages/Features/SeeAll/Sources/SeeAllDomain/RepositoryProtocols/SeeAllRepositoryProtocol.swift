import SharedCore

@MainActor
public protocol SeeAllRepositoryProtocol {
    func fetchNextPage() async -> SeeAllPayload?
}

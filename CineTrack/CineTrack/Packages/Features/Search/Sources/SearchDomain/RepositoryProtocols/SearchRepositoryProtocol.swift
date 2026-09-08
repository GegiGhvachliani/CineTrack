import SharedCore

public protocol SearchRepositoryProtocol: Sendable {
    func searchMovies(query: String, page: Int) async throws -> [Movie]
    func searchActors(query: String, page: Int) async throws -> [Actor]
    func discoverMovies(filters: SearchFilters, page: Int) async throws -> [Movie]
}

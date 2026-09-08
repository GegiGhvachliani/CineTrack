public protocol FetchMovieCastUseCaseProtocol: Sendable {
    func execute(movieID: Int) async throws -> [MovieCastMember]
}

public struct FetchMovieCastUseCase: FetchMovieCastUseCaseProtocol {
    private let repository: MovieDetailsRepositoryProtocol

    public init(repository: MovieDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(movieID: Int) async throws -> [MovieCastMember] {
        try await repository.fetchCast(movieID: movieID)
    }
}

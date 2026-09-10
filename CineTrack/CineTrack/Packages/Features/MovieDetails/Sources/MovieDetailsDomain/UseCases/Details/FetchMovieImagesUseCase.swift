public protocol FetchMovieImagesUseCaseProtocol: Sendable {
    func execute(movieID: Int) async throws -> [MovieImage]
}

public struct FetchMovieImagesUseCase: FetchMovieImagesUseCaseProtocol {

    // MARK: - Properties

    private let repository: MovieDetailsRepositoryProtocol

    // MARK: - Initialization

    public init(repository: MovieDetailsRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(movieID: Int) async throws -> [MovieImage] {
        try await repository.fetchImages(movieID: movieID)
    }
}

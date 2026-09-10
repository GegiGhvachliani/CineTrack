import MovieDetailsDomain
import NewsData
import SharedCore
import SharedNetworking
import TMDBData

public final class MovieDetailsRepository: MovieDetailsRepositoryProtocol, @unchecked Sendable {

    // MARK: - Dependencies

    private let apiClient: APIClient
    private let requestBuilder: TMDBRequestBuilder
    private let newsRequestBuilder: NewsRequestBuilder
    private let movieMapper: MovieMapper
    private let videoMapper: MovieVideoMapper
    private let movieDetailsMapper: MovieDetailsMapper
    private let movieCastMapper: MovieCastMapper
    private let movieImageMapper: MovieImageMapper
    private let newsMapper: NewsMapper

    // MARK: - Initialization

    public init(
        apiClient: APIClient,
        configuration: TMDBConfiguration,
        newsConfiguration: NewsConfiguration
    ) {
        self.apiClient = apiClient
        self.requestBuilder = TMDBRequestBuilder(configuration: configuration)
        self.newsRequestBuilder = NewsRequestBuilder(configuration: newsConfiguration)
        self.movieMapper = MovieMapper()
        self.videoMapper = MovieVideoMapper()
        self.movieDetailsMapper = MovieDetailsMapper()
        self.movieCastMapper = MovieCastMapper()
        self.movieImageMapper = MovieImageMapper()
        self.newsMapper = NewsMapper()
    }

    // MARK: - Movie details

    public func fetchMovieDetails(movieID: Int) async throws -> MovieDetails {
        let request = try requestBuilder.build(for: .movieDetails(movieID: movieID))
        let response: MovieDetailsDTO = try await apiClient.sendRequest(request)

        return movieDetailsMapper.map(response)
    }

    public func fetchCast(movieID: Int) async throws -> [MovieCastMember] {
        let request = try requestBuilder.build(for: .movieCredits(movieID: movieID))
        let response: MovieCreditsResponseDTO = try await apiClient.sendRequest(request)

        return response.cast
            .map(movieCastMapper.map)
            .sorted { ($0.order ?? .max) < ($1.order ?? .max) }
    }

    public func fetchVideos(movieID: Int) async throws -> [MovieVideo] {
        let request = try requestBuilder.build(for: .movieVideos(movieID: movieID))
        let response: MovieVideosResponseDTO = try await apiClient.sendRequest(request)

        return videoMapper.map(response)
    }

    public func fetchImages(movieID: Int) async throws -> [MovieImage] {
        let request = try requestBuilder.build(for: .movieImages(movieID: movieID))
        let response: MovieImagesResponseDTO = try await apiClient.sendRequest(request)

        return (response.backdrops + response.posters).compactMap(movieImageMapper.map)
    }

    // MARK: - Related content

    public func fetchSimilarMovies(movieID: Int, page: Int) async throws -> [Movie] {
        let request = try requestBuilder.build(
            for: .similarMovies(movieID: movieID, page: page)
        )
        let response: MovieListResponseDTO = try await apiClient.sendRequest(request)

        return movieMapper.map(response)
    }

    public func fetchMovies(for actorID: Int) async throws -> [Movie] {
        let request = try requestBuilder.build(
            for: .personMovieCredits(personID: actorID)
        )
        let response: PersonMovieCreditsResponseDTO = try await apiClient.sendRequest(request)

        return response.cast
            .map(movieMapper.map)
            .filter { $0.posterPath != nil }
            .sorted { ($0.releaseDate ?? "") > ($1.releaseDate ?? "") }
    }

    public func fetchNews(movieTitle: String) async throws -> [News] {
        let request = try newsRequestBuilder.build(
            for: .person(name: movieTitle, page: 1, pageSize: 10)
        )
        let response: NewsResponseDTO = try await apiClient.sendRequest(request)

        return response.articles.compactMap(newsMapper.map)
    }
}

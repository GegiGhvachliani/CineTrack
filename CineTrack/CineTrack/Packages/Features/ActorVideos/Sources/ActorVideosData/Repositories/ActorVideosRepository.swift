import ActorVideosDomain
import SharedNetworking
import TMDBData

public final class ActorVideosRepository: ActorVideosRepositoryProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let apiClient: APIClient
    private let requestBuilder: TMDBRequestBuilder
    private let videoMapper: MovieVideoMapper

    // MARK: - Initialization

    public init(
        apiClient: APIClient,
        configuration: TMDBConfiguration,
        videoMapper: MovieVideoMapper = MovieVideoMapper()
    ) {
        self.apiClient = apiClient
        self.requestBuilder = TMDBRequestBuilder(configuration: configuration)
        self.videoMapper = videoMapper
    }

    public func fetchVideos(movieIDs: [Int]) async throws -> [ActorVideo] {
        var seenMovieIDs = Set<Int>()
        let uniqueMovieIDs = movieIDs.filter { seenMovieIDs.insert($0).inserted }

        let videosByMovieID = try await withThrowingTaskGroup(
            of: (Int, [ActorVideo]).self
        ) { group in
            for movieID in uniqueMovieIDs {
                group.addTask { [apiClient, requestBuilder, videoMapper] in
                    let request = try requestBuilder.build(
                        for: .movieVideos(movieID: movieID)
                    )
                    let response: MovieVideosResponseDTO = try await apiClient.sendRequest(request)
                    let videos = videoMapper.map(response).map {
                        ActorVideo(movieID: movieID, video: $0)
                    }
                    return (movieID, videos)
                }
            }

            var result = [Int: [ActorVideo]]()
            for try await (movieID, videos) in group {
                result[movieID] = videos
            }
            return result
        }

        return uniqueMovieIDs.flatMap { videosByMovieID[$0] ?? [] }
    }
}

import Foundation
import ActorDetailsDomain
import SharedNetworking

public final class WikimediaActorMediaRepository: ActorMediaRepositoryProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let apiClient: APIClient

    // MARK: - Initialization

    public init(apiClient: APIClient) { self.apiClient = apiClient }
    public func fetchImages(actorName: String, continuation: String?) async throws -> ActorMediaPage {
        var components = URLComponents(string: "https://commons.wikimedia.org/w/api.php")!
        components.queryItems = [
            .init(name: "action", value: "query"), .init(name: "generator", value: "search"),
            .init(name: "gsrsearch", value: actorName), .init(name: "gsrnamespace", value: "6"),
            .init(name: "gsrlimit", value: "20"), .init(name: "prop", value: "imageinfo"),
            .init(name: "iiprop", value: "url|size"), .init(name: "iiurlwidth", value: "300"),
            .init(name: "format", value: "json")
        ]
        if let continuation { components.queryItems?.append(.init(name: "gsrcontinue", value: continuation)) }
        let response: WikimediaResponse = try await apiClient.sendRequest(
            .init(url: components.url!, headers: ["Accept": "application/json"]))
        let images: [ActorMediaImage] =
            response.query?.pages?.values.compactMap { page in
                guard let info = page.imageinfo?.first,
                    let url = URL(string: info.thumburl ?? info.url)
                else { return nil }
                return ActorMediaImage(
                    id: String(page.pageid), url: url, aspectRatio: Double(info.width) / Double(max(info.height, 1)))
            } ?? []
        return ActorMediaPage(images: images, nextToken: response.continueData?.gsrcontinue)
    }
}

import Foundation

import NewsData
import TMDBData

struct AppConfiguration: AppConfigurationProtocol {

    // MARK: - Configuration

    let tmdb: TMDBConfiguration
    let news: NewsConfiguration

    // MARK: - Initialization

    init(bundle: Bundle = .main) {
        let secrets =
            bundle.url(forResource: "Secrets", withExtension: "plist")
            .flatMap { try? Data(contentsOf: $0) }
            .flatMap { try? PropertyListSerialization.propertyList(from: $0, format: nil) as? [String: String] } ?? [:]

        tmdb = TMDBConfiguration(
            baseURL: URL(string: "https://api.themoviedb.org")!,
            accessToken: secrets["TMDB_ACCESS_TOKEN"] ?? bundle.object(forInfoDictionaryKey: "TMDB_ACCESS_TOKEN")
                as? String ?? ""
        )
        news = NewsConfiguration(
            baseURL: URL(string: "https://newsapi.org")!,
            apiKey: secrets["NEWS_API_KEY"].flatMap { $0.isEmpty ? nil : $0 }
                ?? bundle.object(forInfoDictionaryKey: "NEWS_API_KEY") as? String ?? ""
        )
    }
}

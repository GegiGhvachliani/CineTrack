import NewsData
import TMDBData

protocol AppConfigurationProtocol {
    var tmdb: TMDBConfiguration { get }
    var news: NewsConfiguration { get }
}

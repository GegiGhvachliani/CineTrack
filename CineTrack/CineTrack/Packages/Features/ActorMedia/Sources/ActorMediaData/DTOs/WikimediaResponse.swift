import Foundation

struct WikimediaResponse: Decodable {

    // MARK: - Properties

    let query: Query?
    let continueData: Continuation?

    // MARK: - Coding Keys

    enum CodingKeys: String, CodingKey {
        case query
        case continueData = "continue"
    }

    // MARK: - Response Models

    struct Continuation: Decodable {
        let gsrcontinue: String?
    }

    struct Query: Decodable {
        let pages: [String: Page]?
    }

    struct Page: Decodable {
        let pageid: Int
        let imageinfo: [Info]?
    }

    struct Info: Decodable {
        let url: String
        let thumburl: String?
        let width: Int
        let height: Int
    }
}

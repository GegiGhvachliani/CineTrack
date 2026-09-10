import Foundation

public struct MovieCreditsResponseDTO: Decodable {

    // MARK: - Properties

    public let cast: [MovieCastDTO]
}

public struct MovieCastDTO: Decodable {

    // MARK: - Properties

    public let id: Int
    public let castID: Int?
    public let creditID: String?
    public let name: String
    public let character: String?
    public let profilePath: String?
    public let order: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case castID = "cast_id"
        case creditID = "credit_id"
        case name
        case character
        case profilePath = "profile_path"
        case order
    }
}

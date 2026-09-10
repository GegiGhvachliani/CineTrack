import Foundation

public struct MovieCastMember: Identifiable, Equatable, Sendable {

    // MARK: - Properties

    public let id: Int
    public let creditID: String?
    public let name: String
    public let character: String?
    public let profilePath: String?
    public let profileURL: URL?
    public let order: Int?

    // MARK: - Initialization

    public init(
        id: Int,
        creditID: String?,
        name: String,
        character: String?,
        profilePath: String?,
        profileURL: URL?,
        order: Int?
    ) {
        self.id = id
        self.creditID = creditID
        self.name = name
        self.character = character
        self.profilePath = profilePath
        self.profileURL = profileURL
        self.order = order
    }
}

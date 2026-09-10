import Foundation

public struct AccountSessionUser: Sendable {

    // MARK: - Properties

    public let id: String
    public let email: String?
    public let createdAt: Date?
    public let photoURL: URL?

    // MARK: - Initialization

    public init(id: String, email: String?, createdAt: Date?, photoURL: URL?) {
        self.id = id
        self.email = email
        self.createdAt = createdAt
        self.photoURL = photoURL
    }
}

public protocol AccountSession: UserSession {
    var currentAccount: AccountSessionUser? { get }
    func signOut() throws
}

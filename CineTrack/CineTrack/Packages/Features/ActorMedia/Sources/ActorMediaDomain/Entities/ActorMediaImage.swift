import Foundation

public struct ActorMediaImage: Identifiable, Sendable, Equatable {

    // MARK: - Properties

    public let id: String
    public let url: URL
    public let aspectRatio: Double

    // MARK: - Initialization

    public init(id: String, url: URL, aspectRatio: Double) {
        self.id = id
        self.url = url
        self.aspectRatio = aspectRatio
    }
}

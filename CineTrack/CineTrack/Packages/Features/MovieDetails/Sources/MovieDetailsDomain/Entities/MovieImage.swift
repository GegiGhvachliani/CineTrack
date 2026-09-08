import Foundation

public struct MovieImage: Identifiable, Equatable, Sendable {
    public let id: String
    public let url: URL
    public let aspectRatio: Double

    public init(id: String, url: URL, aspectRatio: Double) {
        self.id = id
        self.url = url
        self.aspectRatio = aspectRatio
    }
}

import Foundation

public protocol ProfilePhotoProcessorProtocol: Sendable {
    func prepare(_ data: Data) throws -> Data
}

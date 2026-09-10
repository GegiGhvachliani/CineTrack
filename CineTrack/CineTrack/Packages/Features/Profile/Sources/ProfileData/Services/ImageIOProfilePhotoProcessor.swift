import Foundation
import ImageIO
import UIKit

import ProfileDomain

public final class ImageIOProfilePhotoProcessor: ProfilePhotoProcessorProtocol {

    // MARK: - Initialization

    public init() {}

    // MARK: - Photo Processing

    public func prepare(_ data: Data) throws -> Data {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil),
            let thumbnail = CGImageSourceCreateThumbnailAtIndex(
                source,
                0,
                [
                    kCGImageSourceCreateThumbnailFromImageAlways: true,
                    kCGImageSourceCreateThumbnailWithTransform: true,
                    kCGImageSourceThumbnailMaxPixelSize: 512
                ] as CFDictionary
            ),
            let compressed = UIImage(cgImage: thumbnail).jpegData(compressionQuality: 0.65)
        else {
            throw ProfileError.invalidPhoto
        }

        return compressed
    }
}

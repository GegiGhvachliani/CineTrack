import Foundation

public struct MovieImagesResponseDTO: Decodable {
    public let backdrops: [MovieImageDTO]
    public let posters: [MovieImageDTO]
}

public struct MovieImageDTO: Decodable {
    public let filePath: String
    public let aspectRatio: Double
    public let width: Int
    public let height: Int

    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
        case aspectRatio = "aspect_ratio"
        case width
        case height
    }
}

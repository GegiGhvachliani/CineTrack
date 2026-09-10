import SwiftUI
import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct GalleryRow: Identifiable {

    // MARK: - Properties

    let images: [GalleryImage]

    var id: String {
        images.map(\.id).joined(separator: "-")
    }
}

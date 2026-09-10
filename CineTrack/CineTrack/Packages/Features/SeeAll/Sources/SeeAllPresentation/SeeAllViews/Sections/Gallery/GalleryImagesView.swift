import SwiftUI
import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct GalleryImagesView: View {

    // MARK: - Properties

    let images: [GalleryImage]

    // MARK: - Body

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(rows) { row in
                        HStack(spacing: 10) {
                            ForEach(row.images) { image in
                                galleryImage(image, row: row, availableWidth: proxy.size.width - 32)
                            }
                        }
                    }
                }
                .padding(16)
            }
            .scrollIndicators(.hidden)
            .background(ColorTokens.Background.secondary)
        }
    }

    private var rows: [GalleryRow] {
        var result: [GalleryRow] = []
        var index = 0

        while index < images.count {
            let image = images[index]

            if image.aspectRatio >= 1.45 {
                result.append(GalleryRow(images: [image]))
                index += 1
            } else if image.aspectRatio < 0.9, index + 2 < images.count {
                result.append(GalleryRow(images: Array(images[index...(index + 2)])))
                index += 3
            } else if index + 1 < images.count {
                result.append(GalleryRow(images: Array(images[index...(index + 1)])))
                index += 2
            } else {
                result.append(GalleryRow(images: [image]))
                index += 1
            }
        }

        return result
    }

    private func galleryImage(
        _ image: GalleryImage,
        row: GalleryRow,
        availableWidth: CGFloat
    ) -> some View {
        let spacing = CGFloat(row.images.count - 1) * 10
        let totalAspectRatio = row.images.reduce(0) { $0 + max($1.aspectRatio, 0.2) }
        let height = (availableWidth - spacing) / totalAspectRatio

        return AsyncImage(url: image.url) { phase in
            if case .success(let image) = phase {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                Rectangle()
                    .fill(ColorTokens.Background.primary)
                    .overlay { ProgressView().tint(ColorTokens.Brand.primary) }
            }
        }
        .frame(width: max(image.aspectRatio, 0.2) * height, height: height)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

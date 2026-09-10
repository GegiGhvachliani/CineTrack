import SwiftUI
import ActorMediaDomain

struct ImagesCell: View {

    // MARK: - Properties

    let image: ActorMediaImage
    let height: CGFloat

    // MARK: - Initialization

    init(
        image: ActorMediaImage,
        height: CGFloat = ActorDetailsLayout.filmographyPosterHeight
    ) {
        self.image = image
        self.height = height
    }

    // MARK: - Body

    var body: some View {
        AsyncImage(url: image.url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            default:
                Rectangle().fill(.gray.opacity(0.3))
            }
        }
        .frame(width: max(CGFloat(image.aspectRatio), 0.1) * height, height: height)
    }
}

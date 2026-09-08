import SwiftUI
import ActorMediaDomain

struct ImagesCell: View {
    let image: ActorMediaImage
    let height: CGFloat

    init(
        image: ActorMediaImage,
        height: CGFloat = ActorDetailsLayout.filmographyPosterHeight
    ) {
        self.image = image
        self.height = height
    }

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

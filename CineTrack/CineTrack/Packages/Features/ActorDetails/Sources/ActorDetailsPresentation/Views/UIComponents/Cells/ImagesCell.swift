import SwiftUI
import ActorMediaDomain

struct ImagesCell: View {
    let image: ActorMediaImage

    var body: some View {
        AsyncImage(url: image.url) { phase in
            switch phase {
            case .success(let image):
                image.resizable().scaledToFill()
            default:
                Rectangle().fill(.gray.opacity(0.3))
            }
        }
        .frame(width: max(CGFloat(image.aspectRatio), 0.1) * 75, height: 75)
        .clipped()
    }
}

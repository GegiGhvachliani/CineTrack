import SwiftUI
import ActorVideosDomain
import DesignSystemTokens

struct VideoCell: View {
    let video: ActorVideo
    let width: CGFloat?
    let height: CGFloat
    let titleLineLimit: Int
    let onTap: () -> Void

    private var titleHeight: CGFloat {
        32
    }

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 6) {
                ZStack {
                    VideoThumbnailView(video: video)

                    Image(systemName: "play.circle.fill")
                        .font(.system(size: width == nil ? 48 : 28))
                        .foregroundStyle(.white)
                        .shadow(radius: 4)
                }
                .frame(maxWidth: width == nil ? .infinity : nil)
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 8))

                Text(video.video.name)
                    .font(width == nil ? TypographyTokens.bodySmall : TypographyTokens.footnote)
                    .foregroundStyle(ColorTokens.Text.main)
                    .lineLimit(titleLineLimit)
                    .frame(maxWidth: width == nil ? .infinity : nil, alignment: .leading)
                    .frame(width: width, height: titleHeight, alignment: .topLeading)
            }
            .frame(
                maxWidth: width == nil ? .infinity : nil,
                minHeight: height + 6 + titleHeight,
                maxHeight: height + 6 + titleHeight,
                alignment: .topLeading
            )
        }
        .buttonStyle(.plain)
    }
}

struct VideoThumbnailView: View {
    let video: ActorVideo

    var body: some View {
        AsyncImage(url: thumbnailURL) { phase in
            switch phase {
            case .empty:
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay { ProgressView() }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay {
                        Image(systemName: "video")
                            .foregroundStyle(.gray)
                    }
            @unknown default:
                EmptyView()
            }
        }
        .clipped()
    }

    private var thumbnailURL: URL? {
        guard video.video.site == .youtube else {
            return nil
        }

        return URL(string: "https://img.youtube.com/vi/\(video.video.key)/hqdefault.jpg")
    }
}

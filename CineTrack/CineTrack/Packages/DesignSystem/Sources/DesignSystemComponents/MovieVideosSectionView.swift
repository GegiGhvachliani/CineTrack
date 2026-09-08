import SwiftUI
import SharedCore
import DesignSystemTokens

public struct MovieVideosSectionView: View {
    private let videos: [MovieVideo]
    @State private var selectedVideo: MovieVideo?

    public init(videos: [MovieVideo]) {
        self.videos = videos
    }

    public var body: some View {
        if let featuredVideo = videos.first {
            VStack(spacing: 6) {
                sectionHeader
                VideoCell(video: featuredVideo, width: nil, height: 200) {
                    selectedVideo = featuredVideo
                }
                .padding(.horizontal, 16)

                if videos.count > 1 {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 10) {
                            ForEach(videos.dropFirst()) { video in
                                VideoCell(video: video, width: 120, height: 75) {
                                    selectedVideo = video
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .frame(height: 113)
                }
            }
            .padding(.top, 15)
            .padding(.bottom, 5)
            .background(ColorTokens.Background.secondary)
            .sheet(item: $selectedVideo) { video in
                VideoDetailView(video: video)
            }
        }
    }

    private var sectionHeader: some View {
        HStack(spacing: 8) {
            Capsule().fill(ColorTokens.Brand.primary).frame(width: 4, height: 25)
            Text("Videos").font(TypographyTokens.headline)
            Spacer()
        }
        .padding(.horizontal)
    }
}

private struct VideoCell: View {
    let video: MovieVideo
    let width: CGFloat?
    let height: CGFloat
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 6) {
                AsyncImage(url: thumbnailURL) { phase in
                    switch phase {
                    case .success(let image): image.resizable().scaledToFill()
                    default: Rectangle().fill(.gray.opacity(0.3)).overlay { Image(systemName: "video") }
                    }
                }
                .frame(maxWidth: width == nil ? .infinity : nil)
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay { Image(systemName: "play.circle.fill").font(.system(size: width == nil ? 48 : 28)).foregroundStyle(.white).shadow(radius: 4) }

                Text(video.name)
                    .font(width == nil ? TypographyTokens.bodySmall : TypographyTokens.footnote)
                    .foregroundStyle(ColorTokens.Text.main)
                    .lineLimit(2)
                    .frame(maxWidth: width == nil ? .infinity : nil, alignment: .leading)
                    .frame(width: width, height: 32, alignment: .topLeading)
            }
        }
        .buttonStyle(.plain)
    }

    private var thumbnailURL: URL? {
        guard video.site == .youtube else { return nil }
        return URL(string: "https://img.youtube.com/vi/\(video.key)/hqdefault.jpg")
    }
}

private struct VideoDetailView: View {
    let video: MovieVideo
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: video.site == .youtube ? URL(string: "https://img.youtube.com/vi/\(video.key)/hqdefault.jpg") : nil) { phase in
                if case .success(let image) = phase { image.resizable().scaledToFill() }
                else { Rectangle().fill(.gray.opacity(0.3)) }
            }
            .frame(height: 230)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            Text(video.name).font(TypographyTokens.headline).multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        .toolbar { ToolbarItem(placement: .topBarTrailing) { Button("Done", action: dismiss.callAsFunction) } }
    }
}

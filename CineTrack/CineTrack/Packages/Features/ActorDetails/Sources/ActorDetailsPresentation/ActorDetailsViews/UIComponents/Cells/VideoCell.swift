//
//  VideoCell.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SwiftUI
import ActorDetailsDomain
import DesignSystemTokens

struct VideoCell: View {

    // MARK: - Properties

    let video: ActorVideo
    let width: CGFloat?
    let height: CGFloat
    let titleLineLimit: Int
    let onTap: () -> Void

    private var titleHeight: CGFloat {
        32
    }

    // MARK: - Body

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 6) {
                ZStack {
                    VideoThumbnailView(video: video)

                    Image(systemName: "play.circle.fill")
                        .font(.system(size: width == nil ? 48 : 28))
                        .foregroundStyle(ColorTokens.Text.onImage)
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

    // MARK: - Properties

    let video: ActorVideo

    // MARK: - Body

    var body: some View {
        AsyncImage(url: thumbnailURL) { phase in
            switch phase {
            case .empty:
                Rectangle()
                    .fill(ColorTokens.Media.placeholder)
                    .overlay { ProgressView() }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                Rectangle()
                    .fill(ColorTokens.Media.placeholder)
                    .overlay {
                        Image(systemName: "video")
                            .foregroundStyle(ColorTokens.Text.secondary)
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

//
//  file.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import SharedCore
import DesignSystemTokens

struct VideoCell: View {

    // MARK: - Properties

    let video: MovieVideo
    let width: CGFloat?
    let height: CGFloat
    let onTap: () -> Void

    // MARK: - Body

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
                .overlay {
                    Image(systemName: "play.circle.fill").font(.system(size: width == nil ? 48 : 28)).foregroundStyle(
                        .white
                    ).shadow(radius: 4)
                }

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

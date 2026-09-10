//
//  PlaylistVideoCell.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI
import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct PlaylistVideoCell: View {

    // MARK: - Properties

    let video: MovieVideo
    let isSelected: Bool
    let isPlaying: Bool
    let action: () -> Void

    // MARK: - Body

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                ZStack {
                    AsyncImage(url: thumbnailURL) { phase in
                        if case .success(let image) = phase {
                            image.resizable().scaledToFill()
                        } else {
                            Rectangle().fill(ColorTokens.Background.primary)
                        }
                    }

                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 34))
                        .foregroundStyle(.white)
                        .shadow(radius: 3)
                }
                .frame(width: 146, height: 88)
                .clipShape(RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 5) {
                    Text(video.name)
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)
                        .lineLimit(2)

                    Text(video.type.rawValue)
                        .font(.system(size: 15, design: .rounded))
                        .foregroundStyle(.white.opacity(0.62))
                }

                Spacer(minLength: 0)
            }
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(isSelected ? ColorTokens.Brand.primary.opacity(0.18) : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private var thumbnailURL: URL? {
        guard video.site == .youtube else { return nil }
        return URL(string: "https://img.youtube.com/vi/\(video.key)/hqdefault.jpg")
    }
}

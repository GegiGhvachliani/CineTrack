//
//  VideosListPlayerSectionView.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct VideosListPlayerSectionView: View {

    // MARK: - Properties

    let movie: Movie
    let video: MovieVideo
    @Binding
    var isPlaying: Bool
    @Binding
    var playbackError: String?
    let onClose: () -> Void

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            playerHeader
                .padding(16)

            EmbeddedVideoPlayer(
                video: video,
                isPlaying: $isPlaying,
                playbackError: $playbackError
            )
            .id(video.id)
            .aspectRatio(16 / 9, contentMode: .fit)
            .frame(minHeight: 200)

            if let playbackError {
                VStack(spacing: 10) {
                    Text(playbackError)
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.7))
                    if let url = URL(string: "https://www.youtube.com/watch?v=\(video.key)") {
                        Link(VideosListStrings.Content.watchOnYouTube, destination: url)
                            .foregroundStyle(ColorTokens.Brand.primary)
                    }
                }
                .padding(16)
            }

        }
        .background(ColorTokens.Background.primary)
    }

    // MARK: - Header

    private var playerHeader: some View {
        HStack(spacing: 14) {
            Button(action: onClose) {
                Image(systemName: "xmark")
                    .font(.system(size: 21, weight: .medium))
                    .foregroundStyle(Color.white)
                    .frame(width: 32, height: 32)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 2) {
                Text(movie.title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(1)

                Text(video.type.rawValue)
                    .font(.system(size: 14, design: .rounded))
                    .foregroundStyle(.white.opacity(0.7))
            }

            Spacer()

        }
    }
}

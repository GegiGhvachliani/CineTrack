//
//  VideosListPlaylistSectionView.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct VideosListPlaylistSectionView: View {

    // MARK: - Properties

    let videos: [MovieVideo]
    let selectedVideoID: String
    let isLoading: Bool
    let errorMessage: String?
    let isPlaying: Bool
    let onSelect: (MovieVideo) -> Void

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(VideosListStrings.Content.playlist)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(ColorTokens.Text.primary)

            if isLoading {
                ProgressView()
                    .tint(ColorTokens.Brand.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 32)
            } else {
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .font(.system(size: 14, design: .rounded))
                        .foregroundStyle(ColorTokens.Text.secondary)
                }

                ForEach(videos) { video in
                    PlaylistVideoCell(
                        video: video,
                        isSelected: video.id == selectedVideoID,
                        isPlaying: video.id == selectedVideoID && isPlaying
                    ) {
                        onSelect(video)
                    }
                }
            }
        }
        .padding(16)
        .background(ColorTokens.Background.secondary)
    }
}

//
//  VideosListView.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI
import SharedCore

public struct VideosListView: View {

    private let item: FeaturedItem

    public init(item: FeaturedItem) {
        self.item = item
    }

    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "video")
                .font(.system(size: 72))
                .foregroundStyle(.secondary)

            Text(item.video.name)
                .font(.title.bold())

            Text("Video Playlist")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemBackground))
        .navigationTitle("Video Playlist")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//
//  MovieHeaderView.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import MovieDetailsDomain
import SharedCore

struct MovieHeaderView: View {

    // MARK: - Properties

    let movie: MovieDetails
    let videos: [MovieVideo]
    let isVideosLoading: Bool
    let onVideoTap: (MovieVideo) -> Void

    // MARK: - Body

    var body: some View {
        if isVideosLoading || !trailerVideos.isEmpty {
            PagingHeaderView(
                title: movie.title,
                subtitle: releaseYear,
                items: trailerVideos,
                isLoading: isVideosLoading
            ) { video in
                Button {
                    onVideoTap(video)
                } label: {
                    trailerCell(for: video)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel(MovieDetailsStrings.Format.play(name: video.name))
            }
        } else {
            Text(movie.title)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(ColorTokens.Brand.primary)
                .lineLimit(3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }

    private var trailerVideos: [MovieVideo] {
        videos.filter { $0.type == .trailer }
    }

    private var releaseYear: String? {
        movie.releaseDate.map { " (\($0.prefix(4)))" }
    }

    private func trailerCell(for video: MovieVideo) -> some View {
        AsyncImage(url: thumbnailURL(for: video)) { phase in
            switch phase {
            case .success(let image):
                image.resizable().scaledToFill()
            default:
                Rectangle().fill(ColorTokens.Background.primary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            Image(systemName: "play.circle.fill")
                .font(.system(size: 54))
                .foregroundStyle(.white)
                .shadow(radius: 4)
        }
        .clipped()
    }

    private func thumbnailURL(for video: MovieVideo) -> URL? {
        guard video.site == .youtube else {
            return nil
        }

        return URL(string: "https://img.youtube.com/vi/\(video.key)/hqdefault.jpg")
    }
}

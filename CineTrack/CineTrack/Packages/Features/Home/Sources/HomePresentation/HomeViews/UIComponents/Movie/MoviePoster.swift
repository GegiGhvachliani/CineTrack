//
//  MoviePoster.swift
//  Home
//
//  Created by Gegi Ghvachliani on 03/08/2026.
//

import SwiftUI
import DesignSystemTokens

struct MoviePoster: View {
    
    let isWatchlisted: Bool
    let photoURL: String?

    let onMovieTap: () -> Void
    let onWatchlistTap: () -> Void

    var body: some View {
        ZStack(alignment: .topLeading) {

            Button(action: onMovieTap) {
                PosterImageView(photoURL: photoURL)
            }
            .buttonStyle(.plain)

            WatchlistButton(
                isAdded: isWatchlisted,
                action: onWatchlistTap
            )
        }
        .clipped()
    }
}


#Preview {
    MoviePoster(isWatchlisted: true, photoURL: "", onMovieTap: {}, onWatchlistTap: {})
        .frame(width: 100, height: 170)
}

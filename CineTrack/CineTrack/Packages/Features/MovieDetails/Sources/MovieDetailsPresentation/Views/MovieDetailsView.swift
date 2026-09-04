//
//  MovieDetailsView.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI
import SharedCore

public struct MovieDetailsView: View {

    private let movie: Movie

    public init(movie: Movie) {
        self.movie = movie
    }

    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "movieclapper")
                .font(.system(size: 72))
                .foregroundStyle(.secondary)

            Text(movie.title)
                .font(.title.bold())

            Text("Movie Details")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .blue))
        .navigationTitle("Movie")
        .navigationBarTitleDisplayMode(.inline)
    }
}

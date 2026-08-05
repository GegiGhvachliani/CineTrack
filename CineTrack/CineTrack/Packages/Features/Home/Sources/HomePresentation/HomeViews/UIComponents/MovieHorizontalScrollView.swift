//
//  MovieHorizontalScrollView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import SharedCore
import DesignSystemTokens

struct MovieHorizontalScrollView<Cell: View>: View {
    
    private let headerText: String
    private let movies: [Movie]

    private let onSeeAllTap: () -> Void
    private let cell: (Movie, Int) -> Cell
    
    init(
        headerText: String,
        movies: [Movie],
        onSeeAllTap: @escaping () -> Void,
        cell: @escaping (Movie, Int) -> Cell
    ) {
        self.headerText = headerText
        self.movies = movies
        self.onSeeAllTap = onSeeAllTap
        self.cell = cell
    }

    var body: some View {
        VStack(spacing: 12) {
            
            header
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 15) {
                    ForEach(Array(movies.enumerated()), id: \.element.id) { index, movie in
                        cell(movie, index)
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.bottom, 10)
            }
        }
    }
    
    // MARK: - header
    

    private var header: some View {
        HStack(spacing: 8) {

            Capsule()
                .frame(width: 4, height: 25)
                .foregroundStyle(
                    ColorTokens.Brand.primary
                )

            Text(headerText)
                .font(TypographyTokens.headline)

            Spacer()

            Button(action: onSeeAllTap) {
                Text("See All")
                    .font(TypographyTokens.bodySmall)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
    }
}

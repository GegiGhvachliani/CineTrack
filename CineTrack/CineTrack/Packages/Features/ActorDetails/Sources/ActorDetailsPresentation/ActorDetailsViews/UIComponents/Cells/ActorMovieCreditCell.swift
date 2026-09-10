//
//  ActorMovieCreditCell.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 06/09/2026.
//

import SwiftUI

import DesignSystemTokens
import ActorDetailsDomain

public struct ActorMovieCreditCell: View {

    // MARK: - Properties

    let credit: ActorCredit

    // MARK: - Initialization

    public init(
        credit: ActorCredit
    ) {
        self.credit = credit
    }

    // MARK: - Body

    public var body: some View {
        ZStack(alignment: .topLeading) {
            movieImage
            movieInfo
        }
        .frame(maxWidth: .infinity)
        .frame(height: 230)
        .clipped()
    }

    private var movieImage: some View {
        ZStack {
            AsyncImage(
                url: credit.backdropURL ?? credit.posterURL
            ) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(.gray.opacity(0.25))
                        .overlay {
                            ProgressView()
                        }

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure:
                    Rectangle()
                        .fill(.gray.opacity(0.25))
                        .overlay {
                            Image(systemName: "film")
                                .font(.largeTitle)
                                .foregroundStyle(.secondary)
                        }

                @unknown default:
                    EmptyView()
                }
            }

            LinearGradient(
                colors: [.clear, ColorTokens.Background.secondary],
                startPoint: .center,
                endPoint: .bottom
            )
        }
    }

    private var movieInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(credit.title)
                .font(TypographyTokens.body)
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 2, x: 1, y: 1)

            if let year = releaseYear {
                Text(year)
                    .font(TypographyTokens.caption)
                    .foregroundStyle(.white.opacity(0.8))
                    .shadow(color: .gray, radius: 1, x: 1, y: 1)
            }

            if let role = credit.character ?? credit.job {
                Text(role)
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.8))
                    .shadow(color: .gray, radius: 1, x: 1, y: 1)
            }
        }
        .padding(.top, 10)
        .padding(.horizontal)
    }

    private var releaseYear: String? {
        guard let releaseDate = credit.releaseDate else {
            return nil
        }

        return String(releaseDate.prefix(4))
    }
}

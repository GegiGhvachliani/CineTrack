//
//  MovieCell.swift
//  Home
//
//  Created by Gegi Ghvachliani on 02/08/2026.
//

import SwiftUI
import SharedCore
import DesignSystemTokens

struct MovieCell: View {
    let movie: Movie
    let cellHeight: CGFloat

    @State private var addedInWatchList: Bool = false
    
    
    var body: some View {
        VStack(spacing: 0) {
            movieImage
                .frame(height: cellHeight * 0.80)
            
            footer
                .frame(height: cellHeight * 0.20)
            
            Spacer()
        }
        .background(ColorTokens.Background.primary)
        .frame(width: cellHeight * (8.0 / 15.0), height: cellHeight)        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 5,
                bottomLeadingRadius: 10,
                bottomTrailingRadius: 10,
                topTrailingRadius: 5
            )
        )
        .shadow(radius: 3, x: 1, y: 3)
    }

    private var movieImage: some View {
        ZStack(alignment: .topLeading) {

            AsyncImage(url: URL(string: movie.posterPath ?? "")) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(ProgressView())
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(Image(systemName: "photo").foregroundStyle(.gray))
                @unknown default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            
            LinearGradient(
                        colors: [.black.opacity(0.6), .clear],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 70)
            
    
            Button {
                addedInWatchList.toggle()
            } label: {
                if addedInWatchList {
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(ColorTokens.Brand.primary)
                        .frame(width: 30)
                        .padding(1)
                        .offset(y: -11)
                        .overlay(
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .frame(width: 10)
                                .bold()
                                .offset(y: -9)
                        )
                } else {
                    
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white.opacity(0.35))
                        .frame(width: 30)
                        .padding(1)
                        .offset(y: -11)
                        .overlay(
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.white)
                                .frame(width: 10)
                                .bold()
                                .offset(y: -9)
                        )
                }
            }
        }
    }
    
    private var footer: some View {
        VStack(spacing: 2) {
            
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 14)
                    .offset(y: -1)
                    .foregroundStyle(ColorTokens.Brand.primary)
                
                Text(String(format: "%.1f", movie.voteAverage))
                    .font(Font.system(size: 15, weight: .none, design: .rounded))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(movie.title)
                .font(Font.system(size: 14, weight: .medium, design: .rounded))
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.top, 5)
        .padding(.horizontal, 6)
    }
}


#Preview {
    let movie: Movie = Movie(title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: nil, voteAverage: 8.9, voteCount: 12)
    
    MovieCell(movie: movie, cellHeight: 240)
}

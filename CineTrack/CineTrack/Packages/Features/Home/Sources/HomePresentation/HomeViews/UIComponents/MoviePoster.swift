//
//  MoviePoster.swift
//  Home
//
//  Created by Gegi Ghvachliani on 03/08/2026.
//

import SwiftUI
import DesignSystemTokens

// struct MoviePoster: View {
//    let photoURL: String?
//    @Binding var addedInWatchlist: Bool
//    
//    var body: some View {
//        ZStack(alignment: .topLeading) {
//            AsyncImage(url: URL(string: photoURL ?? "")) { phase in
//                switch phase {
//                case .empty:
//                    Rectangle()
//                        .fill(Color.gray.opacity(0.3))
//                        .overlay(ProgressView())
//                case .success(let image):
//                    image
//                        .resizable()
//                        .scaledToFill()
//                case .failure:
//                    Rectangle()
//                        .fill(Color.gray.opacity(0.3))
//                        .overlay(Image(systemName: "photo").foregroundStyle(.gray))
//                @unknown default:
//                    EmptyView()
//                }
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .clipped()
//            
//            Button {
//                addedInWatchlist.toggle()
//            } label: {
//                if addedInWatchlist {
//                    Image(systemName: "bookmark.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundStyle(ColorTokens.Brand.primary)
//                        .frame(width: 30)
//                        .padding(1)
//                        .offset(y: -8)
//                        .overlay(
//                            Image(systemName: "checkmark")
//                                .resizable()
//                                .scaledToFit()
//                                .foregroundStyle(.black)
//                                .frame(width: 11)
//                                .bold()
//                                .offset(y: -7)
//                        )
//                } else {
//                    
//                    Image(systemName: "bookmark.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundStyle(.black.opacity(0.65))
//                        .frame(width: 30)
//                        .padding(1)
//                        .offset(y: -8)
//                        .overlay(
//                            Image(systemName: "plus")
//                                .resizable()
//                                .scaledToFit()
//                                .foregroundStyle(.white)
//                                .frame(width: 11)
//                                .bold()
//                                .offset(y: -7)
//                        )
//                }
//            }
//        }
//    }
//}

import SwiftUI
import DesignSystemTokens

struct MoviePoster: View {

    let photoURL: String?

    let isWatchlisted: Bool

    let onMovieTap: () -> Void
    let onWatchlistTap: () -> Void

    var body: some View {
        ZStack(alignment: .topLeading) {

            Button(action: onMovieTap) {
                posterImage
            }
            .buttonStyle(.plain)

            WatchlistButton(
                isAdded: isWatchlisted,
                action: onWatchlistTap
            )
        }
        .clipped()
    }

    // MARK: - Poster Image

    private var posterImage: some View {
        AsyncImage(
            url: URL(string: photoURL ?? "")
        ) { phase in

            switch phase {

            case .empty:
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay {
                        ProgressView()
                    }

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()

            case .failure:
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay {
                        Image(systemName: "photo")
                            .foregroundStyle(.gray)
                    }

            @unknown default:
                EmptyView()
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .clipped()
    }
}


#Preview {
    MoviePoster(photoURL: "", isWatchlisted: true, onMovieTap: {}, onWatchlistTap: {})
        .frame(width: 100, height: 170)
}

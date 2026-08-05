////
////  Top10MovieCell.swift
////  Home
////
////  Created by Gegi Ghvachliani on 03/08/2026.
////
//
//import SwiftUI
//import SharedCore
//import DesignSystemTokens
//
//struct Top10MovieCell: View {
//    let movie: Movie
//    let rank: Int 
//    let cellHeight: CGFloat
//
//    @State private var addedInWatchlist: Bool = false
//    
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            MoviePoster(photoURL: movie.posterPath, addedInWatchlist: $addedInWatchlist)
//                .frame(height: (cellHeight - 25) * 0.8)
//            
//            footer
//                .frame(height: ((cellHeight - 25) * 0.2) + 25)
//            
//            Spacer()
//        }
//        .background(ColorTokens.Background.primary)
//        .frame(width: (cellHeight - 25) * (8.0 / 15.0), height: cellHeight)
//        .clipShape(
//            UnevenRoundedRectangle(
//                topLeadingRadius: 5,
//                bottomLeadingRadius: 10,
//                bottomTrailingRadius: 10,
//                topTrailingRadius: 5
//            )
//        )
//        .shadow(radius: 3, x: 1, y: 3)
//        
//    }
//    
//    private var footer: some View {
//        VStack(spacing: 2) {
//            
//            Text(String(rank))
//                .font(Font.system(size: 20, weight: .bold, design: .rounded))
//                .foregroundStyle(.gray)
//                .frame(maxWidth: .infinity, alignment: .leading)
//
//            
//            HStack(spacing: 4) {
//                Image(systemName: "star.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 14)
//                    .offset(y: -1)
//                    .foregroundStyle(ColorTokens.Brand.primary)
//                
//                
//                Text(String(format: "%.1f", movie.voteAverage))
//                    .font(Font.system(size: 15, weight: .none, design: .rounded))
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            
//            HStack(spacing: 4) {
//                Text(movie.title)
//                    .font(Font.system(size: 14, weight: .medium, design: .rounded))
//                    .lineLimit(1)
//                    .layoutPriority(1)
//                
//                if let releaseDate = movie.releaseDate, !releaseDate.isEmpty {
//                    Text(String(releaseDate.prefix(4)))
//                        .font(Font.system(size: 13, weight: .regular, design: .rounded))
//                        .foregroundStyle(.secondary)
//                        .lineLimit(1)
//                        .layoutPriority(0)
//                }
//                
//                Spacer(minLength: 0)
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//           
//        }
//        .padding(.horizontal, 6)
//    }
//    
//}
//
//
//#Preview {
//    let movie: Movie = Movie(id: 4, title: "SpiderMan: No Way Home", overview: "", posterPath: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg", backdropPath: nil, releaseDate: "2004-07-04", voteAverage: 8.9, voteCount: 12)
//    
//    Top10MovieCell(movie: movie, rank: 2, cellHeight: 265)
//}

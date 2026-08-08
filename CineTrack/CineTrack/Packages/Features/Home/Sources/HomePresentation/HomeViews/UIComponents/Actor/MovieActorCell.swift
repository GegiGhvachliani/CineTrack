//
//  MovieActorCell.swift
//  Home
//
//  Created by Gegi Ghvachliani on 05/08/2026.
//

import SwiftUI
import DesignSystemTokens

public struct MovieActor: Identifiable {
    public let id: Int
    public let name: String
    public let age: Int
    public let profilePath: String?
    public let rank: Int = 1
}

public struct MovieActorCell: View {
    
    let actor: MovieActor
    let cellHeight: CGFloat
    let isFavourited: Bool
    
    let onActorTap: () -> Void
    let onFavouriteTap: () -> Void
    
    public var body: some View {
        VStack(spacing: 0) {
            header
            
            footer
        }
        .frame(width: cellHeight * (8.0 / 15.0), height: cellHeight)
        .foregroundStyle(.white)
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 5,
                bottomLeadingRadius: 10,
                bottomTrailingRadius: 10,
                topTrailingRadius: 5
            )
        )
    }
    
    // MARK: - header
    
    private var header: some View {
        MovieActorPoster(
            isFavourited: isFavourited,
            photoURL: actor.profilePath,
            onActorTap: onActorTap,
            onFavouriteTap: onFavouriteTap
        )
    }
    
    
    // MARK: - footer
    
    private var footer: some View {
        
            VStack (alignment: .leading) {
                Text(actor.name)
                    .font(DesignSystemTokens.TypographyTokens.caption)
                    .lineLimit(2)
                
                Text(String(actor.age))
                    .font(DesignSystemTokens.TypographyTokens.caption)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 3)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: cellHeight * 0.2 + 10)
            .background(ColorTokens.Background.primary)
    }
    
}

//#Preview {
//    let actor = MovieActor(name: "Gagi gagasvhili", age: 13, profilePath: "https://picsum.photos/200/300")
//    MovieActorCell(actor: actor, cellHeight: 230, isFavourited: true, onActorTap: {}, onFavouriteTap: {})
//}

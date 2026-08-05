//
//  MovieActorCell.swift
//  Home
//
//  Created by Gegi Ghvachliani on 05/08/2026.
//

import SwiftUI
import DesignSystemTokens

struct MovieActor {
    let name: String
    let age: Int
    let profilePath: String?
}

struct MovieActorCell: View {
    private var actor: MovieActor
    private var cellHeight: CGFloat
    
    @Binding var isFavourited: Bool
    
    public init(actor: MovieActor, cellHeight: CGFloat, isFavourited: Binding<Bool>) {
        self.actor = actor
        self.cellHeight = cellHeight
        self._isFavourited = isFavourited
    }
    
    var body: some View {
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
    
    // MARK: - Actor Image
    
    private var header: some View {
        ZStack (alignment: .bottomLeading) {
            AsyncImage(url: URL(string: actor.profilePath ?? "")) { phase in
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
            
            Button {
                isFavourited.toggle()
            } label: {
                Circle()
                    .frame(height: 25)
                    .foregroundStyle(.black.opacity(0.5))
                    .overlay {
                        if isFavourited {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 12)
                                .foregroundStyle(ColorTokens.Brand.primary)
                        } else {
                            Image(systemName: "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 12)
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.leading, 5)
                    .padding(.bottom, 10)
                    
            }
        }
        .frame(height: (cellHeight - 10) * 0.8)

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

#Preview {
    let actor = MovieActor(name: "Gagi gagasvhili", age: 13, profilePath: "https://picsum.photos/200/300")
    MovieActorCell(actor: actor, cellHeight: 230, isFavourited: .constant(true))
}

//
//  MoreMoviesFromFavouriteActorView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 08/08/2026.
//

import SwiftUI
import DesignSystemTokens
import SharedCore

struct MoreMoviesFromFavouriteActorView: View {
    
    // ეს იქნება ამოღებული FavouritedActor-დან რენდომად
    let actor: MovieActor

    private let items: [Movie]

    private let onSeeAllTap: () -> Void
    private let onActorTapped: () -> Void
    private let onSeeYourFavouritePeopleTapped: () -> Void
    
    private let cell: (Movie, Int) -> MovieCell
    

    init(
        actor: MovieActor,
        items: [Movie],
        onSeeAllTap: @escaping () -> Void,
        onActorTapped: @escaping () -> Void,
        onSeeYourFavouritePeopleTapped: @escaping () -> Void,
        cell: @escaping (Movie, Int) -> MovieCell
    ) {
        self.actor = actor
        self.items = items
        self.onSeeAllTap = onSeeAllTap
        self.onActorTapped = onActorTapped
        self.onSeeYourFavouritePeopleTapped = onSeeYourFavouritePeopleTapped
        self.cell = cell
    }

    var body: some View {
        VStack(spacing: 12) {

            header

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 15) {
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        cell(item, index)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
            }
            
            footer
        }
        .padding(.top, 15)
        .padding(.bottom, 5)
        .background(ColorTokens.Background.secondary)
    }

    // MARK: - Header

    private var header: some View {
        VStack {
            HStack(spacing: 8) {
                
                Capsule()
                    .frame(width: 4, height: 25)
                    .foregroundStyle(ColorTokens.Brand.primary)
                
                Text("More from \(actor.name)")
                    .font(TypographyTokens.headline)
                
                Spacer()
                
                Button(action: onSeeAllTap) {
                    Text("See All")
                        .font(TypographyTokens.bodySmall)
                    // გადავდივართ ამ მსახიობის ყველა ფილმის ჩამონათვალის გვერდზე
                }
                .buttonStyle(.plain)
            }
            
            Text("because they're one of your favourite people")
                .font(TypographyTokens.bodySmall)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
        .padding(.horizontal)
    }
    
    // MARK: - Footer
    
    private var footer: some View {
        VStack {
            Button {
                onActorTapped()
                // გადადის აქტორის ნათამაშებ ფილმების სიაში
            } label: {
                        // გადადის აქტორის ნათამაშებ ფილმების სიაში
                        HStack {
                        AsyncImage(url: URL(string: actor.profilePath ?? "")) { phase in
                            
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
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .overlay {
                                        Image(systemName: "photo")
                                            .foregroundStyle(.gray)
                                    }
                                
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: 35, height: 35)
                        .cornerRadius(15)
                        .clipped()
                            
                        Text(actor.name)
                            .font(Font.system(size: 18, weight: .regular, design: .rounded))
                            .foregroundColor(ColorTokens.Text.main)
                            
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                            .opacity(0.8)
                            .frame(width: 15, height: 15)
                }
            }
            
            Button {
                // გადადის favourited actors ფილმების სიაზე
                onSeeYourFavouritePeopleTapped()
            } label: {
                HStack {
                    Text("See your favourite people")
                        .foregroundColor(ColorTokens.Text.main)
                        .font(TypographyTokens.body)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                        .opacity(0.8)
                        .frame(width: 15, height: 15)
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}


#Preview {
    // ვიყენებთ სატესტო მსახიობს
    let mockActor = MovieActor(
        id: 1,
        name: "Simon Baker", age: 30,
        profilePath: "https://image.tmdb.org/t/p/w200/profile.jpg"
    )
    
    // ვქმნით სატესტო ფილმებს Movie სტრუქტურის ზუსტი ინიციალიზატორით
    let mockMovies: [Movie] = [
        Movie(
            id: 1,
            title: "The Mentalist: Pilot",
            overview: "A famous psychic reveals himself to be a fake...",
            posterPath: "https://image.tmdb.org/t/p/w500/mentalist_poster.jpg",
            backdropPath: nil,
            releaseDate: "2008-09-23",
            voteAverage: 8.9,
            voteCount: 1500
        ),
        Movie(
            id: 2,
            title: "Margin Call",
            overview: "Follows the key people at an investment bank...",
            posterPath: nil,
            backdropPath: nil,
            releaseDate: "2011-10-21",
            voteAverage: 7.1,
            voteCount: 850
        )
    ]
    
    // ვიძახებთ მთავარ View-ს
    MoreMoviesFromFavouriteActorView(
        actor: mockActor,
        items: mockMovies,
        onSeeAllTap: {},
        onActorTapped: {},
        onSeeYourFavouritePeopleTapped: {},
        cell: { movie, _ in
            // ვიყენებთ შენს MovieCell-ს მისი ზუსტი პარამეტრებით
            MovieCell(
                movie: movie,
                isWatchlisted: false,
                cellHeight: 240,
                onMovieTap: {},
                onWatchlistTap: {}
            )
        }
    )
    .frame(height: 420)
}

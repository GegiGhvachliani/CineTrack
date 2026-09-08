//
//  BiographySectionView.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 06/09/2026.
//

import SwiftUI
import ActorDetailsDomain
import DesignSystemTokens

public struct BiographySectionView: View {
    
    // MARK: - Properties
    
    let actor: ActorDetails
    let profileImageURL: URL?
    let externalLinks: [ActorExternalLink]
    
    let isFavourite: Bool
    let isFavouriteUpdating: Bool
    
    let onFavouriteTap: () -> Void
    let onBiographyTap: () -> Void
    let onExternalLinkTap: (URL) -> Void
    
    // MARK: - Initialization
    
    public init(
        actor: ActorDetails,
        profileImageURL: URL?,
        externalLinks: [ActorExternalLink],
        isFavourite: Bool,
        isFavouriteUpdating: Bool,
        onFavouriteTap: @escaping () -> Void,
        onBiographyTap: @escaping () -> Void,
        onExternalLinkTap: @escaping (URL) -> Void
    ) {
        self.actor = actor
        self.profileImageURL = profileImageURL
        self.externalLinks = externalLinks
        self.isFavourite = isFavourite
        self.isFavouriteUpdating = isFavouriteUpdating
        self.onFavouriteTap = onFavouriteTap
        self.onBiographyTap = onBiographyTap
        self.onExternalLinkTap = onExternalLinkTap
    }
    
    // MARK: - Computed Properties
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .top, spacing: 20) {
                posterImage
                biography
            }

            addToFavouritesButton

            if !externalLinks.isEmpty {
                ExternalLinksScrollView(
                    links: externalLinks,
                    onLinkTap: onExternalLinkTap
                )
            }
        }
        .padding(15)
        .frame(maxWidth: .infinity)
        .background(ColorTokens.Background.secondary)
    }
    
    private var posterImage: some View {
        AsyncImage(url: profileImageURL) { phase in
            
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
                        Image(systemName: "person")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                    }
                
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 120, height: 190)
        .clipped()
    }
    
    private var biography: some View {
        VStack(alignment: .leading, spacing: 16) {

            Button {
                onBiographyTap()
            } label: {
                HStack(spacing: 5) {
                    Text(actor.biography ?? "\(actor.name) biography not found")
                        .font(TypographyTokens.bodySmallSmall)
                        .foregroundStyle(.white.opacity(0.7))
                        .multilineTextAlignment(.leading)
                        .lineLimit(6)
                    
                    Spacer(minLength: 3)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10)
                        .foregroundStyle(.gray)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                if let bornText {
                    Text(bornText)
                        .font(TypographyTokens.body)

                }

                if let diedText {
                    Text(diedText)
                        .font(TypographyTokens.body)
                }
            }
        }
    }
    
    private var addToFavouritesButton: some View {
        Button {
            onFavouriteTap()
        } label: {
            HStack(spacing: 8) {
                Image(systemName: isFavourite ? "checkmark" : "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12)
                
                Text(isFavourite ? "  Added to Favorites" : "  Add to Favorites")
                    .font(Font.system(size: 15, weight: .regular, design: .rounded))
                
                Spacer()
            }
            .padding(.horizontal)
            .foregroundStyle(isFavourite ? .black : ColorTokens.Brand.primary)
            .frame(maxWidth: .infinity)
            .frame(height: 35)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(isFavourite ? ColorTokens.Brand.primary : .clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(ColorTokens.Brand.primary, lineWidth: isFavourite ? 0 : 1)
            )
        }
        .disabled(isFavouriteUpdating)
    }

    private var bornText: String? {
        
        guard let birthday = actor.birthday else {
            return nil
        }
        
        return "Born: \(formattedDate(birthday))"
    }
    
    private var diedText: String? {
        guard let deathday = actor.deathday else {
            return nil
        }
        
        let ageText: String

        if let birthday = actor.birthday {
            let age = Calendar.current.dateComponents(
                [.year],
                from: birthday,
                to: deathday
            ).year ?? 0

            ageText = " (aged \(age))"
        } else {
            ageText = ""
        }

        return "Died: \(formattedDate(deathday))\(ageText)"
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMMM d, yyyy"
        
        return formatter.string(from: date)
    }
}

//
//  HeaderView.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 06/09/2026.
//

import SwiftUI
import ActorDetailsDomain
import DesignSystemTokens

public struct HeaderView: View {
    
    let actor: ActorDetails
    let credits: [ActorCredit]
    
    let isCreditsLoading: Bool
    let onMovieTap: (ActorCredit) -> Void
    
    public init(
        actor: ActorDetails,
        credits: [ActorCredit],
        isCreditsLoading: Bool,
        onMovieTap: @escaping (ActorCredit) -> Void
    ) {
        self.actor = actor
        self.credits = credits
        self.isCreditsLoading = isCreditsLoading
        self.onMovieTap = onMovieTap
    }
    
    public var body: some View {
        VStack(spacing: 10) {
            headerText
            moviesPagingView
        }
    }
    
    private var headerText: some View {
        VStack {
            (Text(actor.name)
                .font(Font.system(size: 25, weight: .semibold, design: .rounded))
                .foregroundStyle(ColorTokens.Brand.primary) +
             Text(lifeYears)
                .font(TypographyTokens.title3)
                .foregroundColor(.secondary)
            )
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private var moviesPagingView: some View {
        if isCreditsLoading {
            ProgressView()
                .frame(maxWidth: .infinity)
                .frame(height: 230)
            
        } else if !credits.isEmpty {
            TabView {
                ForEach(credits) { credit in
                    Button {
                        onMovieTap(credit)
                    } label: {
                        ActorMovieCreditCell(credit: credit)
                    }
                    .buttonStyle(.plain)
                    .tag(credit.id)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .frame(height: 230)
        }
    }
    
    private var lifeYears: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"

        let birthYear = actor.birthday.map(formatter.string(from:)) ?? "—"

        guard let deathday = actor.deathday else {
            return "   \(birthYear)"
        }

        return "  (\(birthYear) – \(formatter.string(from: deathday)))"
    }
}


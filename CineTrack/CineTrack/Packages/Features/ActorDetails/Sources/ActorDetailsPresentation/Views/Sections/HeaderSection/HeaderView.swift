//
//  HeaderView.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 06/09/2026.
//

import SwiftUI
import ActorDetailsDomain
import DesignSystemTokens
import DesignSystemComponents

public struct HeaderView: View {
    
    // MARK: - Properties
    
    let actor: ActorDetails
    let credits: [ActorCredit]
    
    let isCreditsLoading: Bool
    let onMovieTap: (ActorCredit) -> Void
    
    // MARK: - Initialization
    
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
        PagingHeaderView(
            title: actor.name,
            subtitle: lifeYears,
            items: credits,
            isLoading: isCreditsLoading
        ) { credit in
            Button {
                onMovieTap(credit)
            } label: {
                ActorMovieCreditCell(credit: credit)
            }
            .buttonStyle(.plain)
        }
    }
    
    // MARK: - Comuputed Properties
    
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

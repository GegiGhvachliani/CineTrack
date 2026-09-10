//
//  MiniBiographyView.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SwiftUI
import ActorDetailsDomain
import DesignSystemTokens

public struct MiniBiographyView: View {

    // MARK: - Properties

    private let actor: ActorDetails

    // MARK: - Initialization

    public init(actor: ActorDetails) {
        self.actor = actor
    }

    // MARK: - Body

    public var body: some View {
        ScrollView {
            Text(actor.biography ?? ActorDetailsStrings.Format.noBiography(name: actor.name))
                .font(TypographyTokens.bodySmall)
                .foregroundStyle(.white.opacity(0.9))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
        }
        .background(ColorTokens.Background.secondary)
        .navigationTitle(ActorDetailsStrings.Format.miniBiography(name: actor.name))
        .navigationBarTitleDisplayMode(.inline)
    }
}

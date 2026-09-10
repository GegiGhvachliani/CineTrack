//
//  ActorDetailsErrorSectionView.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct ActorDetailsErrorSectionView: View {

    // MARK: - Properties

    let errorMessage: String?
    let onRetry: () -> Void

    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            ContentUnavailableView(
                ActorDetailsStrings.Content.unableToLoadActor,
                systemImage: "exclamationmark.triangle",
                description: Text(
                    errorMessage ?? ActorDetailsStrings.Content.pleaseTryAgain
                )
            )

            Button(ActorDetailsStrings.Content.tryAgain) {
                onRetry()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

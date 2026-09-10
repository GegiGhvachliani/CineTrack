//
//  SeeAllHeaderSectionView.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct SeeAllHeaderSectionView: View {

    // MARK: - Properties

    let title: String
    let onClose: () -> Void

    // MARK: - Body

    var body: some View {
        HStack(spacing: SpacingTokens.small) {
            Capsule()
                .fill(ColorTokens.Brand.primary)
                .frame(width: 4, height: 25)

            Text(title)
                .font(TypographyTokens.headline)

            Spacer()

            Button(SeeAllStrings.Content.done, action: onClose)
                .font(TypographyTokens.bodySmall)
                .foregroundStyle(ColorTokens.Button.textButton)
                .buttonStyle(.plain)
        }
        .padding(.horizontal, SpacingTokens.regular)
        .padding(.vertical, SpacingTokens.medium)
        .background(ColorTokens.Background.secondary)
    }
}

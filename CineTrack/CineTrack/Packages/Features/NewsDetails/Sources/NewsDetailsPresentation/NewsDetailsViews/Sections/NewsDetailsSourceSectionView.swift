//
//  NewsDetailsSourceSectionView.swift
//  NewsDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct NewsDetailsSourceSectionView: View {

    // MARK: - Properties

    let isAvailable: Bool
    let sourceName: String
    let onOpen: () -> Void

    // MARK: - Body

    var body: some View {
        if isAvailable {
            Divider()
                .padding(.horizontal, SpacingTokens.regular)

            Button(action: onOpen) {
                HStack(spacing: SpacingTokens.small) {
                    Text(NewsDetailsStrings.Article.readMore(source: sourceName))
                    Spacer()
                    Image(systemName: "arrow.up.right.square")
                }
                .font(TypographyTokens.bodySmall)
                .foregroundStyle(ColorTokens.Brand.primary)
                .padding(.horizontal, SpacingTokens.regular)
                .frame(height: 44)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(ColorTokens.Brand.primary, lineWidth: 1)
                }
            }
            .padding(.horizontal, SpacingTokens.regular)
        }
    }
}

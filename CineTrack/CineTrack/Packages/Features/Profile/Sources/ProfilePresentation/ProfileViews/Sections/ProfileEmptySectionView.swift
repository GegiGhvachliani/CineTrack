//
//  ProfileEmptySectionView.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import DesignSystemTokens
import LibraryDomain
import SwiftUI

struct ProfileEmptySectionView: View {

    // MARK: - Properties

    let title: String
    let message: String
    let detail: String

    // MARK: - Body

    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 8) {
                Capsule().fill(ColorTokens.Brand.primary).frame(width: 4, height: 25)
                Text(title).font(TypographyTokens.headline)
                Spacer()
            }
            VStack(spacing: 10) {
                Text(message).font(TypographyTokens.bodySmall)
                Text(detail).font(TypographyTokens.caption).foregroundStyle(.secondary)
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 25)
        .background(ColorTokens.Background.secondary)
    }
}

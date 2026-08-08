//
//  WatchlistButton.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import DesignSystemTokens

struct WatchlistButton: View {

    let isAdded: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "bookmark.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(
                    isAdded
                    ? ColorTokens.Brand.primary
                    : .black.opacity(0.5)
                )
                .frame(width: 30)
                .padding(1)
                .offset(y: -8)
                .overlay {
                    Image(
                        systemName: isAdded
                        ? "checkmark"
                        : "plus"
                    )
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(
                        isAdded
                        ? .black
                        : .white
                    )
                    .frame(width: 14)
                    .bold()
                    .offset(y: -7)
                }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(
            isAdded
            ? "Remove from watchlist"
            : "Add to watchlist"
        )
    }
}

#Preview {
    WatchlistButton(isAdded: false, action: {})
}

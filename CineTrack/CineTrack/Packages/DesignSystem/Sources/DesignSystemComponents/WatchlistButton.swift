//
//  file.swift
//  DesignSystem
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import DesignSystemTokens

public struct WatchlistButton: View {

    // MARK: - Properties

    private let isAdded: Bool
    private let size: CGFloat
    private let verticalOffset: CGFloat?
    private let action: () -> Void

    // MARK: - Initialization

    public init(
        isAdded: Bool,
        size: CGFloat = 30,
        verticalOffset: CGFloat? = nil,
        action: @escaping () -> Void
    ) {
        self.isAdded = isAdded
        self.size = size
        self.verticalOffset = verticalOffset
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        Button(action: action) {
            Image(systemName: "bookmark.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(isAdded ? ColorTokens.Brand.primary : .black.opacity(0.5))
                .frame(width: size)
                .padding(1)
                .offset(y: verticalOffset ?? -size * 0.27)
                .overlay {
                    Image(systemName: isAdded ? "checkmark" : "plus")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(isAdded ? .black : .white)
                        .frame(width: size * 0.47)
                        .bold()
                        .offset(y: verticalOffset ?? -size * 0.23)
                }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(isAdded ? "Remove from watchlist" : "Add to watchlist")
    }
}

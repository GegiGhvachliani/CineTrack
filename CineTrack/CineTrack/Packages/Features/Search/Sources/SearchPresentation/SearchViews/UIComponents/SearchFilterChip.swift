//
//  SearchFilterChip.swift
//  Search
//

import SwiftUI

import DesignSystemTokens

struct SearchFilterChip: View {

    // MARK: - Properties

    let title: String
    let isSelected: Bool
    let action: () -> Void

    // MARK: - Body

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(isSelected ? ColorTokens.Text.inverse : ColorTokens.Text.main)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(isSelected ? ColorTokens.Brand.primary : ColorTokens.Background.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        .buttonStyle(.plain)
    }
}

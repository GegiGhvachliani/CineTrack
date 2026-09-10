//
//  SearchModeSectionView.swift
//  Search
//

import SwiftUI

import DesignSystemTokens
import SearchDomain

struct SearchModeSectionView: View {

    // MARK: - Properties

    @Binding
    var selectedMode: SearchMode

    // MARK: - Body

    var body: some View {
        HStack(spacing: 0) {
            ForEach(SearchMode.allCases) { mode in
                Button {
                    selectedMode = mode
                } label: {
                    Text(mode.title)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundStyle(selectedMode == mode ? ColorTokens.Text.onBrand : ColorTokens.Text.main)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .background(
                            selectedMode == mode ? ColorTokens.Brand.primary : Color.clear,
                            in: RoundedRectangle(cornerRadius: 14)
                        )
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(3)
        .background(ColorTokens.Background.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

//
//  SearchModeSectionView.swift
//  Search
//

import SwiftUI

import DesignSystemTokens
import SearchDomain

struct SearchModeSectionView: View {

    @Binding var selectedMode: SearchMode

    var body: some View {
        HStack(spacing: 0) {
            ForEach(SearchMode.allCases) { mode in
                Button {
                    selectedMode = mode
                } label: {
                    Text(mode.rawValue)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundStyle(selectedMode == mode ? ColorTokens.Text.inverse : ColorTokens.Text.main)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .background(selectedMode == mode ? ColorTokens.Brand.primary : Color.clear, in: RoundedRectangle(cornerRadius: 14))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(3)
        .background(ColorTokens.Background.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    SearchModeSectionView(selectedMode: .constant(.recent))
        .padding()
        .background(ColorTokens.Background.main)
}

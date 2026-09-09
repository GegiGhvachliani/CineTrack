//
//  SearchTargetSectionView.swift
//  Search
//

import SwiftUI

import DesignSystemTokens
import SearchDomain

struct SearchTargetSectionView: View {

    @Binding var selectedTarget: SearchTarget

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 0) {
                ForEach(SearchTarget.allCases) { target in
                    Button {
                        selectedTarget = target
                    } label: {
                        Text(target.rawValue)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundStyle(selectedTarget == target ? ColorTokens.Text.inverse : ColorTokens.Text.main)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                            .background(selectedTarget == target ? ColorTokens.Brand.primary : Color.clear, in: RoundedRectangle(cornerRadius: 14))
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
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SearchTargetSectionView(selectedTarget: .constant(.movies))
        .padding()
        .background(.black)
}

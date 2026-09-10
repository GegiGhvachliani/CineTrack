//
//  SearchHeaderSectionView.swift
//  Search
//

import SwiftUI

import DesignSystemTokens
import SearchDomain

struct SearchHeaderSectionView: View {

    // MARK: - Properties

    @Binding
    var searchQuery: String

    let selectedMode: SearchMode
    let selectedTarget: SearchTarget

    // MARK: - Body

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(ColorTokens.Brand.primary)

            TextField(
                selectedTarget == .movies ? SearchStrings.Content.searchMovies : SearchStrings.Content.searchActors,
                text: $searchQuery
            )
            .submitLabel(.search)
            .autocorrectionDisabled()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(ColorTokens.Background.primary)
        .clipShape(Capsule())
        .opacity(selectedMode == .recent ? 1 : 0)
        .allowsHitTesting(selectedMode == .recent)
    }
}

#Preview {
    SearchHeaderSectionView(
        searchQuery: .constant(""),
        selectedMode: .recent,
        selectedTarget: .movies
    )
    .padding()
    .background(ColorTokens.Background.main)
}

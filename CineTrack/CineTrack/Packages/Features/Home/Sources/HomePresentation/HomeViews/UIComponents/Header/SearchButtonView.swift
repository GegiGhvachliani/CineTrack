//
//  SearchButtonView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 05/08/2026.
//

import SwiftUI
import DesignSystemTokens

struct SearchButtonView: View {

    let onTap: () -> Void

    var body: some View {

        Button(action: onTap) {

            HStack(spacing: 5) {

                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                    .frame(width: 40)

                Text("Search for shows, movies, people...")
                    .foregroundStyle(.secondary)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))

                Spacer()
            }
            .padding(.horizontal, 5)
            .frame(height: 30)
            .frame(maxWidth: .infinity)
            .background(.white.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(ColorTokens.Background.primary)
        .accessibilityLabel("Search")
    }
}

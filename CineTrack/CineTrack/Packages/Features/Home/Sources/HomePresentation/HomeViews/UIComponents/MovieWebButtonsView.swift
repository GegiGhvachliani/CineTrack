//
//  MovieWebButtonsView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 07/08/2026.
//

import SwiftUI
import HomeDomain
import DesignSystemTokens

struct MovieWebButtonsView: View {

    // MARK: - Properties

    var body: some View {
        HStack(spacing: 15) {
            makeButton(with: "primeVideo", for: .primeVideo)
            makeButton(with: "paramount+", for: .paramountPlus)
            makeButton(with: "netflix", for: .netflix)
            makeButton(with: "disney+", for: .disneyPlus)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 40)
        .padding(.bottom, 10)
        .padding(.leading, 20)
        .background(ColorTokens.Background.secondary)
    }

    @ViewBuilder
    private func makeButton(with imageName: String, for website: Websites) -> some View {
        if let url = website.url {
            Link(destination: url) {
                Image(imageName, bundle: .module)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.yellow, lineWidth: 3)
                    )
            }
        }
    }
}

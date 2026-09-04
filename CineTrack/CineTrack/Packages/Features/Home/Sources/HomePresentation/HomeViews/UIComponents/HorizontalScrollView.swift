//
//  HorizontalScrollView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import DesignSystemTokens

struct HorizontalScrollView<Item: Identifiable, Cell: View>: View {

    private let headerText: String
    private let items: [Item]

    private let onSeeAllTap: () -> Void
    private let onLoadMore: (() -> Void)?
    private let cell: (Item, Int) -> Cell

    init(
        headerText: String,
        items: [Item],
        onSeeAllTap: @escaping () -> Void,
        onLoadMore: (() -> Void)? = nil,
        cell: @escaping (Item, Int) -> Cell
    ) {
        self.headerText = headerText
        self.items = items
        self.onSeeAllTap = onSeeAllTap
        self.onLoadMore = onLoadMore
        self.cell = cell
    }

    var body: some View {
        VStack(spacing: 12) {

            header

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 15) {

                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in

                        cell(item, index)
                            .onAppear {

                                guard index == items.count - 5 else {
                                    return
                                }

                                onLoadMore?()
                            }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
            }
        }
        .padding(.top, 15)
        .padding(.bottom, 5)
        .background(ColorTokens.Background.secondary)
    }

    private var header: some View {
        HStack(spacing: 8) {

            Capsule()
                .frame(width: 4, height: 25)
                .foregroundStyle(ColorTokens.Brand.primary)

            Text(headerText)
                .font(TypographyTokens.headline)

            Spacer()

            Button(action: onSeeAllTap) {
                Text(HomeStrings.Action.seeAll)
                    .font(TypographyTokens.bodySmall)
                .foregroundStyle(ColorTokens.Button.textButton)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
    }
}

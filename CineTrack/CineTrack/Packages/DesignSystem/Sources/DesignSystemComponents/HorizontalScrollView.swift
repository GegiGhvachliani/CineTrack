//
//  file.swift
//  Home
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import DesignSystemTokens

public struct HorizontalScrollView<Item: Identifiable, Cell: View>: View {

    // MARK: - Properties

    private let headerText: String
    private let seeAllTitle: String
    private let items: [Item]
    private let showsSeeAllButton: Bool
    private let itemSpacing: CGFloat
    private let onSeeAllTap: () -> Void
    private let onLoadMore: (() -> Void)?
    private let cell: (Item, Int) -> Cell

    // MARK: - Initialization

    public init(
        headerText: String,
        seeAllTitle: String,
        items: [Item],
        showsSeeAllButton: Bool = true,
        itemSpacing: CGFloat = 15,
        onSeeAllTap: @escaping () -> Void = {},
        onLoadMore: (() -> Void)? = nil,
        @ViewBuilder cell: @escaping (Item, Int) -> Cell
    ) {
        self.headerText = headerText
        self.seeAllTitle = seeAllTitle
        self.items = items
        self.showsSeeAllButton = showsSeeAllButton
        self.itemSpacing = itemSpacing
        self.onSeeAllTap = onSeeAllTap
        self.onLoadMore = onLoadMore
        self.cell = cell
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 12) {
            header

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: itemSpacing) {
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        cell(item, index)
                            .onAppear {
                                guard items.count >= 5, index == items.count - 5 else {
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

            if showsSeeAllButton {
                Button(action: onSeeAllTap) {
                    Text(seeAllTitle)
                        .font(TypographyTokens.bodySmall)
                        .foregroundStyle(ColorTokens.Button.textButton)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal)
    }
}

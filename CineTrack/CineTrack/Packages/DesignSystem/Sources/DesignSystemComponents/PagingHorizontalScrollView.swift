//
//  file.swift
//  DesignSystem
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import DesignSystemTokens

public struct PagingHorizontalScrollView<Item: Identifiable, Cell: View>: View {

    // MARK: - Properties

    private let headerText: String
    private let seeAllTitle: String
    private let items: [Item]
    private let showsSeeAllButton: Bool
    private let cellWidth: CGFloat
    private let cellHeight: CGFloat
    private let spacing: CGFloat
    private let onSeeAllTap: () -> Void
    private let onLoadMore: (() -> Void)?
    private let cell: (Item, Int) -> Cell
    @State
    private var currentItemID: Item.ID?

    // MARK: - Initialization

    public init(
        headerText: String, seeAllTitle: String, items: [Item], cellWidth: CGFloat, cellHeight: CGFloat,
        spacing: CGFloat = 15, showsSeeAllButton: Bool = true, onSeeAllTap: @escaping () -> Void,
        onLoadMore: (() -> Void)? = nil, @ViewBuilder cell: @escaping (Item, Int) -> Cell
    ) {
        self.headerText = headerText
        self.seeAllTitle = seeAllTitle
        self.items = items
        self.cellWidth = cellWidth
        self.cellHeight = cellHeight
        self.spacing = spacing
        self.showsSeeAllButton = showsSeeAllButton
        self.onSeeAllTap = onSeeAllTap
        self.onLoadMore = onLoadMore
        self.cell = cell
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 12) {
            header
            ScrollView(.horizontal) {
                HStack(spacing: spacing) {
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        cell(item, index)
                            .frame(width: cellWidth, height: cellHeight)
                            .id(item.id)
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $currentItemID, anchor: .leading)
            .frame(height: cellHeight + 10)
            .onAppear {
                if currentItemID == nil {
                    currentItemID = items.first?.id
                }
            }
            .onChange(of: currentItemID) { _, id in
                guard let id, let index = items.firstIndex(where: { $0.id == id }), index >= items.count - 2 else {
                    return
                }
                onLoadMore?()
            }
        }
        .padding(.top, 15)
        .padding(.bottom, 5)
        .background(ColorTokens.Background.secondary)
    }

    // MARK: - Header

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

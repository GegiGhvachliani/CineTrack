//
//  PagingHorizontalScrollView.swift
//  Home
//
//  Created by Gegi Ghvachliani on 11/08/2026.
//

import SwiftUI
import DesignSystemTokens

struct PagingHorizontalScrollView<
    Item: Identifiable,
    Cell: View
>: View {

    let headerText: String
    let items: [Item]

    let cellWidth: CGFloat
    let cellHeight: CGFloat
    let spacing: CGFloat

    let onSeeAllTap: () -> Void
    let onLoadMore: (() -> Void)?
    let cell: (Item, Int) -> Cell

    @State private var currentItemID: Item.ID?

    init(
        headerText: String,
        items: [Item],
        cellWidth: CGFloat,
        cellHeight: CGFloat,
        spacing: CGFloat = 15,
        onSeeAllTap: @escaping () -> Void,
        onLoadMore: (() -> Void)? = nil,
        @ViewBuilder cell: @escaping (Item, Int) -> Cell
    ) {
        self.headerText = headerText
        self.items = items
        self.cellWidth = cellWidth
        self.cellHeight = cellHeight
        self.spacing = spacing
        self.onSeeAllTap = onSeeAllTap
        self.onLoadMore = onLoadMore
        self.cell = cell
    }

    var body: some View {

        VStack(spacing: 12) {

            header

            ScrollView(.horizontal) {

                HStack(spacing: spacing) {

                    ForEach(
                        Array(items.enumerated()),
                        id: \.element.id
                    ) { index, item in

                        cell(item, index)
                            .frame(
                                width: cellWidth,
                                height: cellHeight
                            )
                            .id(item.id)
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(
                id: $currentItemID,
                anchor: .leading
            )
            .frame(
                height: cellHeight + 10
            )
            .onAppear {
                guard currentItemID == nil else {
                    return
                }

                currentItemID = items.first?.id
            }
            .onChange(of: currentItemID) { _, newID in

                guard
                    let newID,
                    let index = items.firstIndex(
                        where: { $0.id == newID }
                    )
                else {
                    return
                }

                guard index >= items.count - 2 else {
                    return
                }

                onLoadMore?()
            }
        }
        .padding(.top, 15)
        .padding(.bottom, 5)
        .background(
            ColorTokens.Background.secondary
        )
    }

    private var header: some View {

        HStack(spacing: 8) {

            Capsule()
                .frame(
                    width: 4,
                    height: 25
                )
                .foregroundStyle(
                    ColorTokens.Brand.primary
                )

            Text(headerText)
                .font(
                    TypographyTokens.headline
                )

            Spacer()

            Button(action: onSeeAllTap) {
                Text("See All")
                    .font(
                        TypographyTokens.bodySmall
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
    }
}

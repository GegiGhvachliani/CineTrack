//
//  file.swift
//  DesignSystem
//
//  Created by Gegi Ghvachliani on 06/08/2026.
//

import SwiftUI
import DesignSystemTokens

public struct PagingHeaderView<Item: Identifiable, Content: View>: View {

    // MARK: - Properties

    private let title: String
    private let subtitle: String?
    private let items: [Item]
    private let isLoading: Bool
    private let content: (Item) -> Content

    // MARK: - Initialization

    public init(
        title: String,
        subtitle: String? = nil,
        items: [Item],
        isLoading: Bool,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.items = items
        self.isLoading = isLoading
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 10) {
            headerText
            pagingContent
        }
    }

    private var headerText: some View {
        (Text(title)
            .font(.system(size: 25, weight: .semibold, design: .rounded))
            .foregroundStyle(ColorTokens.Brand.primary)
            + Text(subtitle ?? "")
            .font(TypographyTokens.title3)
            .foregroundStyle(.secondary))
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }

    @ViewBuilder
    private var pagingContent: some View {
        if isLoading {
            ProgressView()
                .frame(maxWidth: .infinity)
                .frame(height: 230)
        } else if !items.isEmpty {
            TabView {
                ForEach(items) { item in
                    content(item)
                        .tag(item.id)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .frame(height: 230)
        }
    }
}

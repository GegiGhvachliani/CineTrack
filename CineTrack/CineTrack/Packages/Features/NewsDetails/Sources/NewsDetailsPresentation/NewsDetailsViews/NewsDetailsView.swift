//
//  NewsDetailsView.swift
//  NewsDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

public struct NewsDetailsView<ViewModel: NewsDetailsViewModelProtocol>: View {

    // MARK: - Properties

    @State
    private var viewModel: ViewModel

    // MARK: - Initialization

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: SpacingTokens.large) {
                header
                articleImage
                articleDescription
                sourceLink
            }
            .padding(.vertical, SpacingTokens.regular)
        }
        .scrollIndicators(.hidden)
        .background(ColorTokens.Background.secondary)
        .navigationTitle(NewsDetailsStrings.Article.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
    }

    // MARK: - Header

    private var header: some View {
        NewsDetailsHeaderSectionView(title: viewModel.news.title, metadata: viewModel.metadata)
    }

    // MARK: - Image

    private var articleImage: some View {
        NewsImageView(photoURL: viewModel.news.imageURL, height: 225)
            .frame(maxWidth: .infinity)
    }

    // MARK: - Description

    private var articleDescription: some View {
        NewsDetailsDescriptionSectionView(description: viewModel.news.description)
    }

    // MARK: - Source link

    @ViewBuilder
    private var sourceLink: some View {
        NewsDetailsSourceSectionView(
            isAvailable: viewModel.articleURL != nil, sourceName: viewModel.sourceName, onOpen: viewModel.didTapSource)
    }

}

//
//  ActorDetailsView.swift
//  ActorDetailsDomain
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import SwiftUI
import DesignSystemComponents

public struct ActorDetailsView: View {

    // MARK: - ViewModel

    @State var viewModel: ActorDetailsViewModel
    @State private var isNavigationTitleVisible = false

    // MARK: - Initialization

    public init(viewModel: ActorDetailsViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    public var body: some View {
        Group {
            if viewModel.isLoading && viewModel.actor == nil {
                ProgressView()
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.actor == nil {
                errorContent
            } else {
                actorDetailsContent
            }
        }
        .task {
            await viewModel.load()
        }
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Actor details content

    private var actorDetailsContent: some View {
        ScrollView {
            VStack(spacing: 25) {
                scrollOffsetReader
                headerAndBiographySection
                filmographySection
                videosSection
                imagesSection
                relatedNewsSection
                footer
            }
            .padding(.top, 12)
            .padding(.bottom, 16)
        }
        .coordinateSpace(name: "actorDetailsScroll")
        .scrollIndicators(.hidden)
        .onPreferenceChange(ActorDetailsScrollOffsetKey.self) { offset in
            isNavigationTitleVisible = offset < -60
        }
    }

    private var navigationTitle: String {
        guard isNavigationTitleVisible else {
            return ""
        }

        return viewModel.actor?.name ?? ""
    }

    private var scrollOffsetReader: some View {
        GeometryReader { proxy in
            Color.clear.preference(
                key: ActorDetailsScrollOffsetKey.self,
                value: proxy.frame(in: .named("actorDetailsScroll")).minY
            )
        }
        .frame(height: 0)
    }

    // MARK: - Header and biography

    @ViewBuilder
    private var headerAndBiographySection: some View {
        if let actor = viewModel.actor {
            VStack(spacing: 0) {
                HeaderView(
                    actor: actor,
                    credits: viewModel.featuredCredits,
                    isCreditsLoading: viewModel.isCreditsLoading,
                    onMovieTap: { credit in
                        viewModel.didTapCredit(credit)
                    }
                )

                BiographySectionView(
                    actor: actor,
                    profileImageURL: actor.profileURL,
                    externalLinks: viewModel.personalLinks,
                    isFavourite: viewModel.isFavourite,
                    isFavouriteUpdating: viewModel.isFavouriteUpdating,
                    onFavouriteTap: {
                        Task {
                            await viewModel.toggleFavourite()
                        }
                    },
                    onBiographyTap: {
                        viewModel.didTapMiniBiography()
                    },
                    onExternalLinkTap: { url in
                        viewModel.didTapExternalURL(url)
                    }
                )
            }
        }
    }

    // MARK: - Filmography

    @ViewBuilder
    private var filmographySection: some View {
        if !viewModel.filmography.isEmpty {
            FilmographySection(
                credits: viewModel.filmography,
                isWatchlisted: viewModel.isWatchlisted,
                onMovieTap: { credit in
                    viewModel.didTapCredit(credit)
                },
                onWatchlistTap: { credit in
                    Task {
                        await viewModel.toggleWatchlist(for: credit)
                    }
                },
                onSeeAllTap: {
                    viewModel.didTapSeeAllFilmography()
                }
            )
        }
    }

    // MARK: - Videos

    @ViewBuilder
    private var videosSection: some View {
        if !viewModel.actorVideos.isEmpty {
            VideoSectionView(videos: viewModel.actorVideos)
        }
    }

    // MARK: - Images

    @ViewBuilder
    private var imagesSection: some View {
        if !viewModel.mediaImages.isEmpty {
            ImageSectionView(
                images: viewModel.mediaImages,
                onLoadMore: {
                    Task {
                        await viewModel.loadNextMediaPage()
                    }
                }
            )
        }
    }

    // MARK: - Related news

    @ViewBuilder
    private var relatedNewsSection: some View {
        if !viewModel.news.isEmpty {
            RelatedNewsSectionView(
                news: viewModel.news,
                onNewsTap: { news in
                    viewModel.didTapNews(news)
                }
            )
        }
    }

    // MARK: - Footer

    private var footer: some View {
        CineTrackFooterView()
    }

    // MARK: - Error content

    private var errorContent: some View {
        VStack(spacing: 16) {
            ContentUnavailableView(
                "Unable to load actor",
                systemImage: "exclamationmark.triangle",
                description: Text(
                    viewModel.error?.localizedDescription ??
                        "Please try again."
                )
            )

            Button("Try Again") {
                Task {
                    await viewModel.retry()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct ActorDetailsScrollOffsetKey: PreferenceKey {
    static let defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

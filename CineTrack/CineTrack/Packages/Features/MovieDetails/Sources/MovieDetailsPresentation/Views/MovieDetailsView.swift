//
//  MovieDetailsView.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI

import DesignSystemComponents
import MovieDetailsDomain

public struct MovieDetailsView: View {

    @State private var viewModel: MovieDetailsViewModel
    @State private var isNavigationTitleVisible = false

    public init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        Group {
            if viewModel.isLoading && viewModel.movieDetails == nil {
                ProgressView()
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.movieDetails == nil {
                errorContent
            } else {
                movieDetailsContent
            }
        }
        .task {
            await viewModel.load()
        }
        .navigationTitle(isNavigationTitleVisible ? viewModel.movie.title : "")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var movieDetailsContent: some View {
        ScrollView {
            VStack(spacing: 25) {
                scrollOffsetReader
                headerAndInformationSection
                castSection
                similarMoviesSection
                videosSection
                imagesSection
                moreFromActorSection
                relatedNewsSection
                CineTrackFooterView()
            }
            .padding(.top, 12)
            .padding(.bottom, 16)
        }
        .coordinateSpace(name: "movieDetailsScroll")
        .scrollIndicators(.hidden)
        .onPreferenceChange(MovieDetailsScrollOffsetKey.self) { offset in
            isNavigationTitleVisible = offset < -60
        }
    }

    private var scrollOffsetReader: some View {
        GeometryReader { proxy in
            Color.clear.preference(
                key: MovieDetailsScrollOffsetKey.self,
                value: proxy.frame(in: .named("movieDetailsScroll")).minY
            )
        }
        .frame(height: 0)
    }

    @ViewBuilder
    private var headerAndInformationSection: some View {
        if let movieDetails = viewModel.movieDetails {
            VStack(spacing: 0) {
                MovieHeaderView(
                    movie: movieDetails,
                    videos: viewModel.videos,
                    isVideosLoading: viewModel.isVideosLoading
                )

                MovieInfoSectionView(
                    movie: movieDetails,
                    isWatchlisted: viewModel.isWatchlisted,
                    isWatchlistUpdating: viewModel.isWatchlistUpdating,
                    onWatchlistTap: {
                        Task { await viewModel.toggleWatchlist() }
                    }
                )
            }
        }
    }

    @ViewBuilder
    private var castSection: some View {
        if !viewModel.cast.isEmpty {
            AllCastSectionView(
                cast: viewModel.cast,
                onActorTap: viewModel.didTapActor,
                onSeeAllTap: viewModel.didTapSeeAllCast
            )
        }
    }

    @ViewBuilder
    private var similarMoviesSection: some View {
        if !viewModel.similarMovies.isEmpty {
            HorizontalScrollView(
                headerText: "More Like This",
                seeAllTitle: "See All",
                items: viewModel.similarMovies,
                showsSeeAllButton: true,
                onSeeAllTap: viewModel.didTapSeeAllSimilarMovies
            ) { movie, _ in
                MovieCell(
                    movie: movie,
                    isWatchlisted: viewModel.isWatchlisted(movie),
                    cellHeight: 240,
                    onMovieTap: { viewModel.didTapMovie(movie) },
                    onWatchlistTap: { Task { await viewModel.toggleWatchlist(for: movie) } }
                )
            }
        }
    }

    @ViewBuilder
    private var videosSection: some View {
        if let featuredVideo = viewModel.featuredVideo {
            MovieVideosSectionView(videos: [featuredVideo] + viewModel.additionalVideos)
        }
    }

    @ViewBuilder
    private var imagesSection: some View {
        if !viewModel.images.isEmpty {
            ImageGallerySectionView(
                items: viewModel.images,
                imageURL: \.url,
                aspectRatio: \.aspectRatio,
                onSeeAllTap: viewModel.didTapSeeAllImages
            )
        }
    }

    @ViewBuilder
    private var moreFromActorSection: some View {
        if let actor = viewModel.selectedActor, !viewModel.selectedActorMovies.isEmpty {
            MoreFromActorSectionView(
                actorName: actor.name,
                movies: viewModel.selectedActorMovies,
                isWatchlisted: viewModel.isWatchlisted,
                onMovieTap: viewModel.didTapMovie,
                onWatchlistTap: { movie in
                    Task { await viewModel.toggleWatchlist(for: movie) }
                },
                onSeeAllTap: viewModel.didTapSeeAllActorMovies
            )
        }
    }

    @ViewBuilder
    private var relatedNewsSection: some View {
        if !viewModel.news.isEmpty {
            PagingHorizontalScrollView(
                headerText: "Related News",
                seeAllTitle: "See All",
                items: viewModel.news,
                cellWidth: 307.5,
                cellHeight: 205,
                showsSeeAllButton: true,
                onSeeAllTap: viewModel.didTapSeeAllNews
            ) { article, _ in
                NewsCell(news: article, cellHeight: 205) {
                    viewModel.didTapNews(article)
                }
            }
        }
    }

    private var errorContent: some View {
        VStack(spacing: 16) {
            ContentUnavailableView(
                "Unable to load movie",
                systemImage: "exclamationmark.triangle",
                description: Text(viewModel.error?.localizedDescription ?? "Please try again.")
            )

            Button("Try Again") {
                Task { await viewModel.retry() }
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct MovieDetailsScrollOffsetKey: PreferenceKey {
    static let defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

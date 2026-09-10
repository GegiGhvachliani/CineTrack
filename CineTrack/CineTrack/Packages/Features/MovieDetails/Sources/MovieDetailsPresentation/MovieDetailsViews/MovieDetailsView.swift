//
//  MovieDetailsView.swift
//  MovieDetails
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SwiftUI
import LibraryDomain

import DesignSystemComponents
import MovieDetailsDomain

public struct MovieDetailsView<ViewModel: MovieDetailsViewModelProtocol>: View {

    // MARK: - Properties

    @State
    private var viewModel: ViewModel
    @State
    private var isNavigationTitleVisible = false

    // MARK: - Initialization

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

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
        .toolbar(.visible, for: .navigationBar)
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
                    isVideosLoading: viewModel.isVideosLoading,
                    onVideoTap: viewModel.didTapVideo
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
        SimilarMoviesSectionView(
            movies: viewModel.similarMovies,
            isWatchlisted: viewModel.isWatchlisted,
            onMovieTap: viewModel.didTapMovie,
            onWatchlistTap: { movie in
                Task { await viewModel.toggleWatchlist(for: movie) }
            },
            onSeeAllTap: viewModel.didTapSeeAllSimilarMovies
        )
    }

    @ViewBuilder
    private var videosSection: some View {
        if let featuredVideo = viewModel.videosSectionFeaturedVideo {
            MovieVideosSectionView(
                videos: [featuredVideo] + viewModel.videosSectionAdditionalVideos,
                onVideoTap: viewModel.didTapVideo
            )
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
        MovieRelatedNewsSectionView(
            news: viewModel.news,
            onNewsTap: viewModel.didTapNews,
            onSeeAllTap: viewModel.didTapSeeAllNews
        )
    }

    private var errorContent: some View {
        MovieDetailsErrorSectionView(errorMessage: viewModel.error?.localizedDescription) {
            Task { await viewModel.retry() }
        }
    }
}

import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

public struct SeeAllView<ViewModel: SeeAllViewModelProtocol>: View {

    // MARK: - ViewModel

    @State
    private var viewModel: ViewModel

    // MARK: - Initialization

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header

                Group {
                    switch viewModel.payload {
                    case .movies(let movies):
                        movieList(movies)
                    case .actors(let actors):
                        actorList(actors)
                    case .news(let news):
                        newsList(news)
                    case .images(let images):
                        GalleryImagesView(images: images)
                    case .library(let items):
                        libraryList(items)
                    }
                }
            }
            .overlay(alignment: .bottom) {
                if viewModel.isLoadingMore {
                    ProgressView()
                        .padding()
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    // MARK: - Header

    private var header: some View {
        SeeAllHeaderSectionView(title: viewModel.title, onClose: viewModel.close)
    }

    // MARK: - Lists

    private func libraryList(_ items: [SeeAllLibraryItem]) -> some View {
        SeeAllLibrarySectionView(
            items: items,
            onMovieTap: viewModel.didTapMovie,
            onActorTap: viewModel.didTapActor
        )
    }

    private func movieList(_ movies: [Movie]) -> some View {
        SeeAllMovieSectionView(
            movies: movies,
            onTap: viewModel.didTapMovie,
            onLoadMore: loadMoreIfNeeded
        )
    }

    private func actorList(_ actors: [Actor]) -> some View {
        SeeAllActorSectionView(
            actors: actors,
            onTap: viewModel.didTapActor,
            onLoadMore: loadMoreIfNeeded
        )
    }

    private func newsList(_ news: [News]) -> some View {
        SeeAllNewsSectionView(
            news: news,
            onTap: viewModel.didTapNews,
            onLoadMore: loadMoreIfNeeded
        )
    }

    // MARK: - Pagination

    private func loadMoreIfNeeded(index: Int, count: Int) {
        Task { await viewModel.loadMoreIfNeeded(index: index, count: count) }
    }
}

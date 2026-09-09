import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

public struct SeeAllView: View {

    // MARK: - Properties

    private let content: SeeAllContent
    private let onMovieTap: (Movie) -> Void
    private let onActorTap: (Actor) -> Void
    private let onNewsTap: (News) -> Void
    @Environment(\.dismiss) private var dismiss

    // MARK: - Initialization

    public init(
        content: SeeAllContent,
        onMovieTap: @escaping (Movie) -> Void = { _ in },
        onActorTap: @escaping (Actor) -> Void = { _ in },
        onNewsTap: @escaping (News) -> Void = { _ in }
    ) {
        self.content = content
        self.onMovieTap = onMovieTap
        self.onActorTap = onActorTap
        self.onNewsTap = onNewsTap
    }

    // MARK: - Body

    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header

                Group {
                    switch content.payload {
                    case .movies(let movies):
                        movieList(movies)
                    case .actors(let actors):
                        actorList(actors)
                    case .news(let news):
                        newsList(news)
                    case .images(let images):
                        GalleryImagesView(images: images)
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack(spacing: SpacingTokens.small) {
            Capsule()
                .fill(ColorTokens.Brand.primary)
                .frame(width: 4, height: 25)

            Text(content.title)
                .font(TypographyTokens.headline)

            Spacer()

            Button("Done", action: dismiss.callAsFunction)
                .font(TypographyTokens.bodySmall)
                .foregroundStyle(ColorTokens.Button.textButton)
                .buttonStyle(.plain)
        }
        .padding(.horizontal, SpacingTokens.regular)
        .padding(.vertical, SpacingTokens.medium)
        .background(ColorTokens.Background.secondary)
    }

    // MARK: - Lists

    private func movieList(_ movies: [Movie]) -> some View {
        List(movies) { movie in
            Button { onMovieTap(movie) } label: { CompactMovieCell(movie: movie) }
                .buttonStyle(.plain)
                .onAppear { loadMoreIfNeeded(index: movies.firstIndex(where: { $0.id == movie.id }) ?? 0, count: movies.count) }
                .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                .listRowBackground(ColorTokens.Background.secondary)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(ColorTokens.Background.secondary)
        .overlay { emptyState(isEmpty: movies.isEmpty) }
    }

    private func actorList(_ actors: [Actor]) -> some View {
        List(actors) { actor in
            Button { onActorTap(actor) } label: { CompactActorCell(actor: actor) }
                .buttonStyle(.plain)
                .onAppear { loadMoreIfNeeded(index: actors.firstIndex(where: { $0.id == actor.id }) ?? 0, count: actors.count) }
                .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                .listRowBackground(ColorTokens.Background.secondary)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(ColorTokens.Background.secondary)
        .overlay { emptyState(isEmpty: actors.isEmpty) }
    }

    private func newsList(_ news: [News]) -> some View {
        List(news) { article in
            Button { onNewsTap(article) } label: { CompactNewsCell(news: article) }
                .buttonStyle(.plain)
                .onAppear { loadMoreIfNeeded(index: news.firstIndex(where: { $0.id == article.id }) ?? 0, count: news.count) }
                .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                .listRowBackground(ColorTokens.Background.secondary)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(ColorTokens.Background.secondary)
        .overlay { emptyState(isEmpty: news.isEmpty) }
    }

    @ViewBuilder
    private func emptyState(isEmpty: Bool) -> some View {
        if isEmpty {
            ContentUnavailableView("Nothing to show", systemImage: "tray")
        }
    }

    private func loadMoreIfNeeded(index: Int, count: Int) {
        guard count >= 5, index >= count - 3 else { return }
        Task { await content.loadNextPage() }
    }
}

// MARK: - Image gallery

private struct GalleryImagesView: View {
    let images: [GalleryImage]

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(rows) { row in
                        HStack(spacing: 10) {
                            ForEach(row.images) { image in
                                galleryImage(image, row: row, availableWidth: proxy.size.width - 32)
                            }
                        }
                    }
                }
                .padding(16)
            }
            .scrollIndicators(.hidden)
            .background(ColorTokens.Background.secondary)
        }
    }

    private var rows: [GalleryRow] {
        var result: [GalleryRow] = []
        var index = 0

        while index < images.count {
            let image = images[index]

            if image.aspectRatio >= 1.45 {
                result.append(GalleryRow(images: [image]))
                index += 1
            } else if image.aspectRatio < 0.9, index + 2 < images.count {
                result.append(GalleryRow(images: Array(images[index...(index + 2)])))
                index += 3
            } else if index + 1 < images.count {
                result.append(GalleryRow(images: Array(images[index...(index + 1)])))
                index += 2
            } else {
                result.append(GalleryRow(images: [image]))
                index += 1
            }
        }

        return result
    }

    private func galleryImage(
        _ image: GalleryImage,
        row: GalleryRow,
        availableWidth: CGFloat
    ) -> some View {
        let spacing = CGFloat(row.images.count - 1) * 10
        let totalAspectRatio = row.images.reduce(0) { $0 + max($1.aspectRatio, 0.2) }
        let height = (availableWidth - spacing) / totalAspectRatio

        return AsyncImage(url: image.url) { phase in
            if case .success(let image) = phase {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                Rectangle()
                    .fill(ColorTokens.Background.primary)
                    .overlay { ProgressView().tint(ColorTokens.Brand.primary) }
            }
        }
        .frame(width: max(image.aspectRatio, 0.2) * height, height: height)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

private struct GalleryRow: Identifiable {
    let images: [GalleryImage]

    var id: String {
        images.map(\.id).joined(separator: "-")
    }
}

// MARK: - Compact cells

private struct CompactMovieCell: View {
    let movie: Movie

    var body: some View {
        HStack(spacing: SpacingTokens.medium) {
            PosterImageView(photoURL: movie.posterPath)
                .frame(width: 46, height: 68)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            VStack(alignment: .leading, spacing: SpacingTokens.xSmall) {
                Text(movie.title)
                    .font(TypographyTokens.bodySmall)
                    .foregroundStyle(ColorTokens.Text.main)
                    .lineLimit(2)

                HStack(spacing: SpacingTokens.small) {
                    if let releaseDate = movie.releaseDate {
                        Text(String(releaseDate.prefix(4)))
                    }
                    Image(systemName: "star.fill")
                        .foregroundStyle(ColorTokens.Brand.primary)
                    Text(String(format: "%.1f", movie.voteAverage))
                }
                .font(TypographyTokens.footnote)
                .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}

private struct CompactActorCell: View {
    let actor: Actor

    var body: some View {
        HStack(spacing: SpacingTokens.medium) {
            PosterImageView(photoURL: actor.profilePath)
                .frame(width: 54, height: 54)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: SpacingTokens.xSmall) {
                Text(actor.name)
                    .font(TypographyTokens.bodySmall)
                    .foregroundStyle(ColorTokens.Text.main)
                    .lineLimit(1)

                if let age = actor.age {
                    Text("\(age) years old")
                        .font(TypographyTokens.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}

private struct CompactNewsCell: View {
    let news: News

    var body: some View {
        HStack(spacing: SpacingTokens.medium) {
            PosterImageView(photoURL: news.imageURL)
                .frame(width: 72, height: 54)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            VStack(alignment: .leading, spacing: SpacingTokens.xSmall) {
                Text(news.title)
                    .font(TypographyTokens.bodySmall)
                    .foregroundStyle(ColorTokens.Text.main)
                    .lineLimit(2)

                Text(news.author ?? "News")
                    .font(TypographyTokens.footnote)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}

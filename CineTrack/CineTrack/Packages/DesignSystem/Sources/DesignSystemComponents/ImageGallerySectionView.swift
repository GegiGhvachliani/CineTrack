import SwiftUI

public struct ImageGallerySectionView<Item: Identifiable>: View {

    // MARK: - Properties

    private let items: [Item]
    private let imageURL: (Item) -> URL
    private let aspectRatio: (Item) -> Double
    private let onLoadMore: (() -> Void)?
    private let onSeeAllTap: () -> Void

    // MARK: - Initialization

    public init(
        items: [Item],
        imageURL: @escaping (Item) -> URL,
        aspectRatio: @escaping (Item) -> Double,
        onSeeAllTap: @escaping () -> Void,
        onLoadMore: (() -> Void)? = nil
    ) {
        self.items = items
        self.imageURL = imageURL
        self.aspectRatio = aspectRatio
        self.onSeeAllTap = onSeeAllTap
        self.onLoadMore = onLoadMore
    }

    // MARK: - Body

    public var body: some View {
        if !items.isEmpty {
            HorizontalScrollView(
                headerText: "Images",
                seeAllTitle: "See All",
                items: items,
                itemSpacing: 10,
                onSeeAllTap: onSeeAllTap,
                onLoadMore: onLoadMore
            ) { item, _ in
                imageCell(item, height: 133)
            }

        }
    }

    private func imageCell(_ item: Item, height: CGFloat) -> some View {
        AsyncImage(url: imageURL(item)) { phase in
            if case .success(let image) = phase {
                image.resizable().scaledToFit()
            } else {
                Rectangle().fill(.gray.opacity(0.3))
            }
        }
        .frame(width: max(CGFloat(aspectRatio(item)), 0.1) * height, height: height)
    }
}

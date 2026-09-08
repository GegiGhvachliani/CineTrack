import SwiftUI

public struct ImageGallerySectionView<Item: Identifiable>: View {
    private let items: [Item]
    private let imageURL: (Item) -> URL
    private let aspectRatio: (Item) -> Double
    private let onLoadMore: (() -> Void)?
    @State private var showsGallery = false

    public init(
        items: [Item],
        imageURL: @escaping (Item) -> URL,
        aspectRatio: @escaping (Item) -> Double,
        onLoadMore: (() -> Void)? = nil
    ) {
        self.items = items
        self.imageURL = imageURL
        self.aspectRatio = aspectRatio
        self.onLoadMore = onLoadMore
    }

    public var body: some View {
        if !items.isEmpty {
            HorizontalScrollView(
                headerText: "Images",
                seeAllTitle: "See All",
                items: items,
                itemSpacing: 10,
                onSeeAllTap: { showsGallery = true },
                onLoadMore: onLoadMore
            ) { item, _ in
                imageCell(item, height: 133)
            }
            .sheet(isPresented: $showsGallery) {
                ScrollView {
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 140), spacing: 10)],
                        spacing: 10
                    ) {
                        ForEach(items) { item in
                            imageCell(item, height: 180)
                                .frame(maxWidth: .infinity, minHeight: 180)
                        }
                    }
                    .padding()
                }
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

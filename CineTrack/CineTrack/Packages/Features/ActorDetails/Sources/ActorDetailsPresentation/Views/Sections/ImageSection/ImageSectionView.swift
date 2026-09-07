import SwiftUI
import ActorMediaDomain
import DesignSystemComponents

struct ImageSectionView: View {
    let images: [ActorMediaImage]
    let onLoadMore: () -> Void
    @State private var showsGallery = false

    var body: some View {
        if !images.isEmpty {
            HorizontalScrollView(
                headerText: "Images",
                seeAllTitle: "See All",
                items: images,
                itemSpacing: 10,
                onSeeAllTap: { showsGallery = true },
                onLoadMore: onLoadMore
            ) { image, _ in
                ImagesCell(image: image)
            }
            .sheet(isPresented: $showsGallery) {
                ImagesGalleryView(images: images)
            }
        }
    }
}

private struct ImagesGalleryView: View {
    let images: [ActorMediaImage]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 10)], spacing: 10) {
                ForEach(images) { image in
                    ImagesCell(image: image)
                        .frame(maxWidth: .infinity, minHeight: 180)
                }
            }
            .padding()
        }
    }
}

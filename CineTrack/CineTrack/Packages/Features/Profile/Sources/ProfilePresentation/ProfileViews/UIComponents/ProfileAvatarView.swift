import DesignSystemTokens
import SwiftUI

struct ProfileAvatarView: View {

    // MARK: - Properties

    let photoData: Data?
    let photoURL: URL?
    let isLoading: Bool

    // MARK: - Body

    var body: some View {
        avatar
            .frame(width: 92, height: 92)
            .clipShape(Circle())
            .overlay(alignment: .bottomTrailing) {
                Image(systemName: "camera.fill")
                    .font(.system(size: 13))
                    .foregroundStyle(.black)
                    .padding(8)
                    .background(ColorTokens.Brand.primary, in: Circle())
            }
            .overlay {
                if isLoading {
                    ProgressView().tint(.white)
                }
            }
    }

    // MARK: - Avatar

    @ViewBuilder
    private var avatar: some View {
        if let data = photoData, let image = UIImage(data: data) {
            Image(uiImage: image).resizable().scaledToFill()
        } else {
            AsyncImage(url: photoURL) { phase in
                if case .success(let image) = phase {
                    image.resizable().scaledToFill()
                } else {
                    Circle().fill(ColorTokens.Background.primary)
                        .overlay {
                            Image(systemName: "person.fill").font(.system(size: 42)).foregroundStyle(
                                .secondary
                            )
                        }
                }
            }
        }
    }
}

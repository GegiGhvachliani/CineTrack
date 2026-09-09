import DesignSystemTokens
import ImageIO
import PhotosUI
import ProfileDomain
import SwiftUI

struct ProfileHeaderView: View {
    let account: ProfileAccount?
    let isUpdatingPhoto: Bool
    let isSigningOut: Bool
    let onPhotoSelected: (Data) async -> Void
    let onPhotoError: (String) -> Void
    let onSignOut: () -> Void
    @State private var selection: PhotosPickerItem?
    @State private var isPreparingPhoto = false

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .top) {
                PhotosPicker(selection: $selection, matching: .images) {
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
                        .overlay { if isUpdatingPhoto || isPreparingPhoto { ProgressView().tint(.white) } }
                }
                .disabled(isUpdatingPhoto || isPreparingPhoto || isSigningOut)
                .accessibilityLabel("Change profile photo")
                Spacer()
                Button(action: onSignOut) {
                    Text(isSigningOut ? "Signing Out…" : "Sign Out")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundStyle(ColorTokens.Brand.primary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(ColorTokens.Brand.primary.opacity(0.12), in: Capsule())
                        .contentShape(Capsule())
                }
                .buttonStyle(.plain)
                .disabled(isSigningOut || isUpdatingPhoto || isPreparingPhoto)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(account?.email ?? "Your account")
                    .font(.system(size: 23, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                if let date = account?.createdAt {
                    Label("Joined \(date.formatted(.dateTime.month(.wide).year()))", systemImage: "calendar")
                        .font(.system(size: 14, design: .rounded))
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ColorTokens.Background.secondary)
        .task(id: selection) { await loadPhoto() }
    }

    // MARK: - Photo

    @ViewBuilder
    private var avatar: some View {
        if let data = account?.photoData, let image = UIImage(data: data) {
            Image(uiImage: image).resizable().scaledToFill()
        } else {
            AsyncImage(url: account?.photoURL) { phase in
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

    private func loadPhoto() async {
        guard let selection else { return }
        isPreparingPhoto = true
        defer { isPreparingPhoto = false }
        do {
            guard let data = try await selection.loadTransferable(type: Data.self),
                let source = CGImageSourceCreateWithData(data as CFData, nil),
                let thumbnail = CGImageSourceCreateThumbnailAtIndex(
                    source,
                    0,
                    [
                        kCGImageSourceCreateThumbnailFromImageAlways: true,
                        kCGImageSourceCreateThumbnailWithTransform: true,
                        kCGImageSourceThumbnailMaxPixelSize: 512,
                    ] as CFDictionary
                ),
                let compressed = UIImage(cgImage: thumbnail).jpegData(compressionQuality: 0.65)
            else {
                onPhotoError("This photo couldn't be opened. Please choose another image.")
                return
            }
            try Task.checkCancellation()
            await onPhotoSelected(compressed)
        } catch is CancellationError {
            return
        } catch { onPhotoError(error.localizedDescription) }
    }
}

#Preview {
    ProfileHeaderView(
        account: ProfileAccount(email: "gegi@example.com", createdAt: .now, photoURL: nil),
        isUpdatingPhoto: false,
        isSigningOut: false,
        onPhotoSelected: { _ in },
        onPhotoError: { _ in },
        onSignOut: {}
    )
    .preferredColorScheme(.dark)
}

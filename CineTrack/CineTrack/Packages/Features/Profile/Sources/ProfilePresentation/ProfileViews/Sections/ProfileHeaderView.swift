//
//  ProfileHeaderView.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import DesignSystemTokens
import PhotosUI
import ProfileDomain
import SwiftUI

struct ProfileHeaderView: View {

    // MARK: - Properties

    let account: ProfileAccount?
    let isUpdatingPhoto: Bool
    let isSigningOut: Bool
    let onPhotoSelected: (Data) async -> Void
    let onPhotoError: (String) -> Void
    let onSignOut: () -> Void
    @State
    private var selection: PhotosPickerItem?
    @State
    private var isPreparingPhoto = false

    // MARK: - Body

    var body: some View {
        let photoLabel = ProfileAvatarView(
            photoData: account?.photoData,
            photoURL: account?.photoURL,
            isLoading: isUpdatingPhoto || isPreparingPhoto
        )

        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .top) {
                PhotosPicker(selection: $selection, matching: .images) {
                    photoLabel
                }
                .disabled(isUpdatingPhoto || isPreparingPhoto || isSigningOut)
                .accessibilityLabel(ProfileStrings.Content.changeProfilePhoto)
                Spacer()
                Button(action: onSignOut) {
                    Text(isSigningOut ? ProfileStrings.Content.signingOut : ProfileStrings.Content.signOut)
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
                let email = account?.email ?? ""
                Text(email.isEmpty ? ProfileStrings.Content.yourAccount : email)
                    .font(.system(size: 23, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                if let date = account?.createdAt {
                    Label(
                        ProfileStrings.Format.joined(date: date.formatted(.dateTime.month(.wide).year())),
                        systemImage: "calendar"
                    )
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

    private func loadPhoto() async {
        guard let selection else { return }
        isPreparingPhoto = true
        defer { isPreparingPhoto = false }
        do {
            guard let data = try await selection.loadTransferable(type: Data.self)
            else {
                onPhotoError(ProfileStrings.Content.invalidPhoto)
                return
            }
            try Task.checkCancellation()
            await onPhotoSelected(data)
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

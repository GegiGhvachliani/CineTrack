//
//  ProfileViewModel.swift
//  Profile
//
//  Created by Gegi Ghvachliani on 22/06/2026.
//

import Foundation
import LibraryDomain
import Observation
import ProfileDomain
import SharedCore

extension ProfileViewModel {

    // MARK: - Account

    public func savePhoto(_ data: Data) async {
        guard !isUpdatingPhoto, !isSigningOut else { return }
        isUpdatingPhoto = true
        defer { isUpdatingPhoto = false }
        do {
            account?.photoData = try await updateProfilePhotoUseCase.execute(data: data)
        } catch {
            errorMessage = error is ProfileError ? ProfileStrings.Content.invalidPhoto : error.localizedDescription
        }
    }

    public func signOut() async {
        guard !isSigningOut, !isLoading, !isUpdatingPhoto, pendingItems.isEmpty else { return }
        isSigningOut = true
        defer { isSigningOut = false }
        do {
            try await signOutUseCase.execute()
            onSignedOut?()
        } catch {
            errorMessage = error is ProfileError ? ProfileStrings.Content.invalidPhoto : error.localizedDescription
        }
    }
}

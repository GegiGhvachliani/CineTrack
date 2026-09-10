//
//  VideosListViewModel.swift
//  VideosList
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import Foundation
import Observation
import SharedCore
import VideosListDomain

extension VideosListViewModel {

    // MARK: - Loading

    public func loadPlaylist() async {
        guard playlist.isEmpty, !isLoading else {
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            errorMessage = nil
            playlist = try await fetchPlaylistVideosUseCase.execute(context: context)
        } catch is CancellationError {
            return
        } catch {
            errorMessage = VideosListStrings.Content.playlistUnavailable
            playlist = [selectedVideo]
        }
    }
}

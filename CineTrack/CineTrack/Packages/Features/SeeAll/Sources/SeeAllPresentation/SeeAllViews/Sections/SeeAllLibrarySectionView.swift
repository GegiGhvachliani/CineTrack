import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct SeeAllLibrarySectionView: View {

    // MARK: - Properties

    let items: [SeeAllLibraryItem]
    let onMovieTap: (Movie) -> Void
    let onActorTap: (Actor) -> Void

    // MARK: - Body

    var body: some View {
        List(items) { item in
            Group {
                switch item {
                case .movie(let movie):
                    Button {
                        onMovieTap(movie)
                    } label: {
                        CompactMovieCell(movie: movie)
                    }
                case .actor(let actor):
                    Button {
                        onActorTap(actor)
                    } label: {
                        CompactActorCell(actor: actor)
                    }
                }
            }
            .buttonStyle(.plain)
            .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
            .listRowBackground(ColorTokens.Background.secondary)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(ColorTokens.Background.secondary)
        .overlay { SeeAllEmptyStateView(isEmpty: items.isEmpty) }
    }
}

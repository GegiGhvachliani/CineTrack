import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct SeeAllActorSectionView: View {

    // MARK: - Properties

    let actors: [Actor]
    let onTap: (Actor) -> Void
    let onLoadMore: (Int, Int) -> Void

    // MARK: - Body

    var body: some View {
        List(actors) { actor in
            Button {
                onTap(actor)
            } label: {
                CompactActorCell(actor: actor)
            }
            .buttonStyle(.plain)
            .onAppear {
                loadMoreIfNeeded(index: actors.firstIndex(where: { $0.id == actor.id }) ?? 0, count: actors.count)
            }
            .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
            .listRowBackground(ColorTokens.Background.secondary)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(ColorTokens.Background.secondary)
        .overlay { SeeAllEmptyStateView(isEmpty: actors.isEmpty) }
    }

    // MARK: - Pagination

    private func loadMoreIfNeeded(index: Int, count: Int) {
        onLoadMore(index, count)
    }
}

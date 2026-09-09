import SwiftUI

import DesignSystemComponents
import DesignSystemTokens
import MovieDetailsDomain

struct AllCastSectionView: View {
    let cast: [MovieCastMember]
    let onActorTap: (MovieCastMember) -> Void
    let onSeeAllTap: () -> Void

    var body: some View {
        HorizontalScrollView(
            headerText: "All Cast",
            seeAllTitle: "See All",
            items: cast,
            showsSeeAllButton: true,
            itemSpacing: 12,
            onSeeAllTap: onSeeAllTap
        ) { actor, _ in
            Button {
                onActorTap(actor)
            } label: {
                VStack(alignment: .leading, spacing: 6) {
                    AsyncImage(url: actor.profileURL) { phase in
                        if case .success(let image) = phase {
                            image.resizable().scaledToFill()
                        } else {
                            Rectangle().fill(.gray.opacity(0.3))
                                .overlay { Image(systemName: "person.fill") }
                        }
                    }
                    .frame(width: 110, height: 132)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    Text(actor.name)
                        .font(TypographyTokens.bodySmall)
                        .foregroundStyle(ColorTokens.Text.main)
                        .lineLimit(1)

                    Text(actor.character ?? "—")
                        .font(TypographyTokens.footnote)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                .frame(width: 110, alignment: .leading)
            }
            .buttonStyle(.plain)
        }
    }
}

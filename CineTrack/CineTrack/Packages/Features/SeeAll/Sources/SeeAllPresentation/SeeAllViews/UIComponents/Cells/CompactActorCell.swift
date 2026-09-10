import SwiftUI
import DesignSystemComponents
import DesignSystemTokens
import SharedCore

struct CompactActorCell: View {

    // MARK: - Properties

    let actor: Actor

    // MARK: - Body

    var body: some View {
        HStack(spacing: SpacingTokens.medium) {
            PosterImageView(photoURL: actor.profilePath)
                .frame(width: 54, height: 54)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: SpacingTokens.xSmall) {
                Text(actor.name)
                    .font(TypographyTokens.bodySmall)
                    .foregroundStyle(ColorTokens.Text.main)
                    .lineLimit(1)

                if let age = actor.age {
                    Text(SeeAllStrings.Format.age(years: age))
                        .font(TypographyTokens.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}

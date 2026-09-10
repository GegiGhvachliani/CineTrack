import SwiftUI
import DesignSystemComponents
import LibraryDomain
import DesignSystemTokens
import SharedCore

struct MoreMoviesFromFavouriteActorSectionView: View {

    // MARK: - Properties

    let actor: Actor
    let movies: [Movie]
    let watchlistedMovies: [Movie]

    let onMovieTap: (Movie) -> Void
    let onWatchlistTap: (Movie) -> Void
    let onSeeAllTap: () -> Void
    let onActorTap: () -> Void
    let onSeeYourFavouritePeopleTap: () -> Void

    // MARK: - Body

    var body: some View {
        VStack(spacing: 12) {
            header

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 15) {
                    ForEach(movies) { movie in
                        MovieCell(
                            movie: movie,
                            isWatchlisted: watchlistedMovies.contains {
                                $0.id == movie.id
                            },
                            cellHeight: 240,
                            onMovieTap: {
                                onMovieTap(movie)
                            },
                            onWatchlistTap: {
                                onWatchlistTap(movie)
                            }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
            }

            footer
        }
        .padding(.top, 15)
        .padding(.bottom, 10)
        .background(ColorTokens.Background.secondary)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                Capsule()
                    .fill(ColorTokens.Brand.primary)
                    .frame(width: 4, height: 25)

                Text(HomeStrings.Format.moreFromHeader(actorName: actor.name))
                    .font(TypographyTokens.headline)

                Spacer()

                Button(HomeStrings.Action.seeAll, action: onSeeAllTap)
                    .font(TypographyTokens.bodySmall)
                    .foregroundStyle(ColorTokens.Button.textButton)
                    .buttonStyle(.plain)
            }

            Text(HomeStrings.Content.becauseTheyreOneOfYourFavouritePeople)
                .font(TypographyTokens.bodySmall)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
    }

    private var footer: some View {
        VStack(spacing: 12) {
            Button(action: onActorTap) {
                HStack(spacing: 10) {
                    actorImage

                    Text(actor.name)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundStyle(ColorTokens.Text.main)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
            }
            .padding(.bottom, 5)
            .buttonStyle(.plain)

            Button(action: onSeeYourFavouritePeopleTap) {
                HStack {
                    Text(HomeStrings.Content.seeYourFavouritePeople)
                        .font(TypographyTokens.bodySmall)
                        .foregroundStyle(ColorTokens.Text.main)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private var actorImage: some View {
        AsyncImage(url: URL(string: actor.profilePath ?? "")) { phase in
            switch phase {
            case .empty:
                ProgressView()

            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()

            case .failure:
                Image(systemName: "person.fill")
                    .foregroundStyle(.secondary)

            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 33, height: 33)
        .background(Color.gray.opacity(0.2))
        .clipShape(Circle())
    }
}

import SwiftUI

public struct ActorDetailsView: View {
    @State private var viewModel: ActorDetailsViewModel

    public init(viewModel: ActorDetailsViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    public var body: some View {
        Group {
            if viewModel.isLoading && viewModel.actor == nil {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.error {
                ContentUnavailableView(
                    "Unable to load actor",
                    systemImage: "exclamationmark.triangle",
                    description: Text(error.localizedDescription)
                )
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                    if let actor = viewModel.actor {
                        HeaderView(
                            actor: actor,
                            credits: viewModel.featuredCredits,
                            isCreditsLoading: viewModel.isCreditsLoading,
                            onMovieTap: { credit in
                                viewModel.didTapCredit(credit)
                            }
                        )

                        BiographySectionView(
                            actor: actor,
                            profileImageURL: actor.profileURL,
                            externalLinks: viewModel.externalLinks?.links ?? [],
                            isFavourite: viewModel.isFavourite,
                            isFavouriteUpdating: viewModel.isFavouriteUpdating,
                            onFavouriteTap: {
                                Task {
                                    await viewModel.toggleFavourite()
                                }
                            },
                            onBiographyTap: {
                                viewModel.didTapMiniBiography()
                            },
                            onExternalLinkTap: { url in
                                viewModel.didTapExternalURL(url)
                            }
                        )
                        .padding(.bottom, 20)

                        FilmographySection(
                            credits: viewModel.filmography,
                            isWatchlisted: viewModel.isWatchlisted,
                            onMovieTap: { credit in
                                viewModel.didTapCredit(credit)
                            },
                            onWatchlistTap: { credit in
                                Task {
                                    await viewModel.toggleWatchlist(for: credit)
                                }
                            },
                            onSeeAllTap: {
                                viewModel.didTapSeeAllFilmography()
                            }
                        )
                        .frame(height: 210, alignment: .top)
                    }
                    }
                    .padding(.vertical)
                }
            }
            
        }
        .task {
            await viewModel.load()
        }
    }
}

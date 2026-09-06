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
                    if let actor = viewModel.actor {
                        HeaderView(
                            actor: actor,
                            credits: viewModel.featuredCredits,
                            isCreditsLoading: viewModel.isCreditsLoading,
                            onMovieTap: { credit in
                                viewModel.didTapCredit(credit)
                            }
                        )
                    }
                }
            }
            
        }
        .task {
            await viewModel.load()
        }
    }
}

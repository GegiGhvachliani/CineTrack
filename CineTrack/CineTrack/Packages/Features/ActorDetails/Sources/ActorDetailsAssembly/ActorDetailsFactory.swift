import UIKit
import SwiftUI

import ActorDetailsData
import ActorDetailsDomain
import ActorDetailsPresentation
import ActorDetailsPresentationAPI
import SharedCore
import SharedNetworking
import SharedAuth
import SharedStorage
import TMDBData
import NewsData

@MainActor
public struct ActorDetailsFactory: ActorDetailsFactoryProtocol {
    public init() {}

    public func makeActorDetailsCoordinator(
        actorID: Int,
        navigationController: UINavigationController,
        router: ActorDetailsRoutingProtocol
    ) -> ActorDetailsCoordinatorProtocol {
        ActorDetailsCoordinator(
            actorID: actorID,
            navigationController: navigationController,
            factory: self,
            router: router
        )
    }

    public func makeActorDetailsViewController(
        actorID: Int,
        onMovieDetails: @escaping (Movie) -> Void,
        onNewsDetails: @escaping (News) -> Void,
        onShowAllPhotos: @escaping ([ActorImage], String) -> Void,
        onShowMiniBiography: @escaping (ActorDetails) -> Void,
        onShowAllFilmography: @escaping () -> Void
    ) -> UIViewController {
        let apiClient = URLSessionAPIClient()
        let tmdbConfiguration = TMDBConfiguration(
            baseURL: URL(string: "https://api.themoviedb.org")!,
            accessToken: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NWEyZmRkNjQyY2FmOTMzYTVjMzk5N2VkY2VjYTRjNSIsIm5iZiI6MTc2Mzk4OTQxNS42MDA5OTk4LCJzdWIiOiI2OTI0NTdhN2EwYzRiMWIxMzIxODc1ZGIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.ZfESC0ZJHYqzbSE2xCYRjfOSwiacjs7sYl-_qvgDbc4"
        )
        let newsConfiguration = NewsConfiguration(
            baseURL: URL(string: "https://newsapi.org")!,
            apiKey: Bundle.main.object(forInfoDictionaryKey: "NEWS_API_KEY") as? String ?? ""
        )
        let repository = ActorDetailsRepository(
            apiClient: apiClient,
            configuration: tmdbConfiguration,
            newsConfiguration: newsConfiguration
        )
        let favouriteRepository = FavouriteActorRepository(
            firestore: FirestoreClient(),
            userSession: FirebaseUserSession()
        )
        let watchlistRepository = WatchlistRepository(
            firestore: FirestoreClient(),
            userSession: FirebaseUserSession()
        )
        let viewModel = ActorDetailsViewModel(
            actorID: actorID,
            fetchActorDetailsUseCase: FetchActorDetailsUseCase(repository: repository),
            fetchActorCreditsUseCase: FetchActorCreditsUseCase(repository: repository),
            fetchActorImagesUseCase: FetchActorImagesUseCase(repository: repository),
            fetchActorExternalLinksUseCase: FetchActorExternalLinksUseCase(repository: repository),
            fetchActorNewsUseCase: FetchActorNewsUseCase(repository: repository),
            fetchFavouritedActorsUseCase: FetchFavouritedActorsUseCase(repository: favouriteRepository),
            addFavouritedActorUseCase: AddFavouritedActorUseCase(repository: favouriteRepository),
            removeFavouritedActorUseCase: RemoveFavouritedActorUseCase(repository: favouriteRepository),
            fetchWatchlistedMoviesUseCase: FetchWatchlistedMoviesUseCase(repository: watchlistRepository),
            addWatchlistedMovieUseCase: AddWatchlistedMovieUseCase(repository: watchlistRepository),
            removeWatchlistedMovieUseCase: RemoveWatchlistedMovieUseCase(repository: watchlistRepository)
        )
        viewModel.onMovieDetails = onMovieDetails
        viewModel.onNewsDetails = onNewsDetails
        viewModel.onShowAllPhotos = onShowAllPhotos
        viewModel.onShowMiniBiography = onShowMiniBiography
        viewModel.onShowAllFilmography = onShowAllFilmography
        viewModel.onOpenURL = { url in
            UIApplication.shared.open(url)
        }

        return UIHostingController(rootView: ActorDetailsView(viewModel: viewModel))
    }

    public func makeActorPhotosViewController(
        images: [ActorImage],
        actorName: String
    ) -> UIViewController {
        UIHostingController(rootView: ActorPhotosView(images: images, actorName: actorName))
    }

    public func makeMiniBiographyViewController(actor: ActorDetails) -> UIViewController {
        UIHostingController(rootView: MiniBiographyView(actor: actor))
    }
}

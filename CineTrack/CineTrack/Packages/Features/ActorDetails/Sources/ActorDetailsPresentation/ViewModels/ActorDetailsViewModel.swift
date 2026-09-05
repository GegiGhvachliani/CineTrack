//
//  ActorDetailsViewModel.swift
//  ActorDetails
//
//  Created by Gegi Ghvachliani on 05/09/2026.
//

import Foundation
import Observation

import ActorDetailsDomain

@MainActor
public protocol ActorDetailsViewModelProtocol: AnyObject {

    var actor: ActorDetails? { get }
    var credits: [ActorCredit] { get }
    var images: [ActorImage] { get }
    var externalLinks: ActorExternalLinks? { get }

    var isLoading: Bool { get }
    var error: Error? { get }

    var actorID: Int { get }

    func load() async
    func retry() async
}

@MainActor
@Observable
public final class ActorDetailsViewModel: ActorDetailsViewModelProtocol {

    // MARK: - State

    public private(set) var actor: ActorDetails?
    public private(set) var credits: [ActorCredit] = []
    public private(set) var images: [ActorImage] = []
    public private(set) var externalLinks: ActorExternalLinks?

    public private(set) var isLoading = false
    public private(set) var error: Error?

    // MARK: - Input

    public let actorID: Int

    // MARK: - Dependencies

    private let fetchActorDetailsUseCase: FetchActorDetailsUseCaseProtocol
    private let fetchActorCreditsUseCase: FetchActorCreditsUseCaseProtocol
    private let fetchActorImagesUseCase: FetchActorImagesUseCaseProtocol
    private let fetchActorExternalLinksUseCase: FetchActorExternalLinksUseCaseProtocol

    // MARK: - Initialization

    public init(
        actorID: Int,
        fetchActorDetailsUseCase: FetchActorDetailsUseCaseProtocol,
        fetchActorCreditsUseCase: FetchActorCreditsUseCaseProtocol,
        fetchActorImagesUseCase: FetchActorImagesUseCaseProtocol,
        fetchActorExternalLinksUseCase: FetchActorExternalLinksUseCaseProtocol
    ) {
        self.actorID = actorID
        self.fetchActorDetailsUseCase = fetchActorDetailsUseCase
        self.fetchActorCreditsUseCase = fetchActorCreditsUseCase
        self.fetchActorImagesUseCase = fetchActorImagesUseCase
        self.fetchActorExternalLinksUseCase = fetchActorExternalLinksUseCase
    }

    // MARK: - Actions

    public func load() async {
        guard !isLoading else {
            return
        }

        isLoading = true
        error = nil

        defer {
            isLoading = false
        }

        do {
            async let actorDetails =
                fetchActorDetailsUseCase.execute(
                    actorID: actorID
                )

            async let actorCredits =
                fetchActorCreditsUseCase.execute(
                    actorID: actorID
                )

            async let actorImages =
                fetchActorImagesUseCase.execute(
                    actorID: actorID
                )

            async let actorExternalLinks =
                fetchActorExternalLinksUseCase.execute(
                    actorID: actorID
                )

            let (
                loadedActor,
                loadedCredits,
                loadedImages,
                loadedExternalLinks
            ) = try await (
                actorDetails,
                actorCredits,
                actorImages,
                actorExternalLinks
            )

            actor = loadedActor
            credits = loadedCredits
            images = loadedImages
            externalLinks = loadedExternalLinks

        } catch {
            self.error = error
        }
    }

    public func retry() async {
        await load()
    }
}

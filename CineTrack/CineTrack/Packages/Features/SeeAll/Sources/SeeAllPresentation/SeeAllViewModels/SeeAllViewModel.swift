//
//  SeeAllViewModel.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import Observation

import SeeAllDomain
import SharedCore

@Observable
@MainActor
public final class SeeAllViewModel: SeeAllViewModelProtocol {

    // MARK: - Content

    public let title: String
    public internal(set) var payload: SeeAllPayload
    public internal(set) var isLoadingMore = false

    // MARK: - Actions

    public var onMovieTap: ((Movie) -> Void)?
    public var onActorTap: ((Actor) -> Void)?
    public var onNewsTap: ((News) -> Void)?

    public var onClose: (() -> Void)?

    // MARK: - Dependencies (UseCases)

    internal let fetchPageUseCase: FetchSeeAllPageUseCaseProtocol

    // MARK: - Initialization

    public init(title: String, payload: SeeAllPayload, fetchPageUseCase: FetchSeeAllPageUseCaseProtocol) {
        self.title = title
        self.payload = payload
        self.fetchPageUseCase = fetchPageUseCase
    }

}

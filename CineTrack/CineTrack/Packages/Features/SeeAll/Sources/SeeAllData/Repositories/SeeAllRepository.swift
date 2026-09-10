//
//  SeeAllRepository.swift
//  SeeAll
//
//  Created by Gegi Ghvachliani on 04/09/2026.
//

import SeeAllDomain
import SharedCore

public final class SeeAllRepository: SeeAllRepositoryProtocol {

    // MARK: - Dependencies

    private let content: SeeAllContent

    // MARK: - Initialization

    public init(content: SeeAllContent) {
        self.content = content
    }

    // MARK: - Pagination

    public func fetchNextPage() async -> SeeAllPayload? {
        guard content.hasMore(), let loadMore = content.loadMore else {
            return nil
        }

        return await loadMore()
    }
}

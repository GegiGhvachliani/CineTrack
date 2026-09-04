//
//  HomeViewModel+News.swift
//  Home
//
//  Created by Gegi Ghvachliani on 13/08/2026.
//


import Foundation

import HomeDomain
import SharedCore

extension HomeViewModel {

    public func loadNextNewsPage() async {

        guard !isNewsLoading, hasMoreNews else { return }

        isNewsLoading = true

        defer {
            isNewsLoading = false
        }

        do {
            
            let page = try await fetchNewsUseCase.execute(page: newsPage)

            news.append(contentsOf: page.news)

            newsPage += 1

            hasMoreNews = news.count < page.totalResults

        } catch {
            print("❌ News Error:", error)
            self.error = error
        }
    }
}

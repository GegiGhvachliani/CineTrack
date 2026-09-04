//
//  HomeViewModel+Actors.swift
//  Home
//
//  Created by Gegi Ghvachliani on 13/08/2026.
//


import Foundation

import HomeDomain
import SharedCore

extension HomeViewModel {

    // MARK: - Born Today Actors

    public func loadNextBornTodayActorsPage() async {

        guard !isBornTodayActorsLoading, hasMoreBornTodayActors else { return }

        isBornTodayActorsLoading = true

        defer {
            isBornTodayActorsLoading = false
        }

        do {
            
            let page = try await fetchBornTodayActorsUseCase.execute(page: bornTodayActorsPage)

            bornTodayActors.append(contentsOf: page.actors)

            bornTodayActorsPage += 1

            hasMoreBornTodayActors = page.hasNextPage

        } catch {
            print("❌ Born Today Error:", error)
            self.error = error
        }
    }

    // MARK: - Most Popular Actors

    public func loadNextMostPopularCelebritiesPage() async {

        guard !isMostPopularCelebritiesLoading, hasMoreMostPopularCelebrities else { return }

        isMostPopularCelebritiesLoading = true

        defer {
            isMostPopularCelebritiesLoading = false
        }

        do {
            
            let page = try await fetchMostPopularActorsUseCase.execute(page: mostPopularCelebritiesPage)

            mostPopularActors.append(contentsOf: page.actors)

            mostPopularCelebritiesPage += 1

            hasMoreMostPopularCelebrities = page.hasNextPage

        } catch {
            print("❌ Most Popular Actors Error:", error)
            self.error = error
        }
    }
}

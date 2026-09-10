//
//  HomeRepository+Actors.swift
//  Home
//
//  Created by Gegi Ghvachliani on 12/08/2026.
//

import Foundation
import HomeDomain
import SharedCore
import SharedNetworking
import TMDBData

extension HomeRepository {

    // MARK: - Born Today

    public func fetchBornTodayActors(page: Int) async throws -> ActorPage {

        let firstPopularPage = ((page - 1) * popularPeoplePagesPerRequest) + 1

        let lastPopularPage = firstPopularPage + popularPeoplePagesPerRequest - 1

        let popularPeoplePages = try await fetchPopularPeoplePages(from: firstPopularPage, to: lastPopularPage)

        let people = popularPeoplePages.flatMap(\.results)

        let actors = await filterBornTodayActors(people)

        let hasNextPage = popularPeoplePages.contains {
            $0.page < $0.totalPages
        }

        return ActorPage(actors: actors, page: page, hasNextPage: hasNextPage)
    }

    // MARK: - Most Popular Actors

    public func fetchMostPopularActors(page: Int) async throws -> ActorPage {

        let request = try requestBuilder.build(for: .popularPeople(page: page))

        let response: PopularPeopleResponseDTO = try await apiClient.sendRequest(request)

        let actors = response.results.compactMap {
            personMapper.map($0)
        }

        return ActorPage(actors: actors, page: response.page, hasNextPage: response.page < response.totalPages)
    }

    // MARK: - Private

    private func fetchPopularPeoplePages(from firstPage: Int, to lastPage: Int) async throws
        -> [PopularPeopleResponseDTO] {

        try await withThrowingTaskGroup(of: PopularPeopleResponseDTO.self) { group in

            for page in firstPage...lastPage {
                group.addTask { [apiClient, requestBuilder] in

                    let request = try requestBuilder.build(
                        for: .popularPeople(
                            page: page
                        )
                    )

                    return try await apiClient.sendRequest(request)
                }
            }

            var responses: [PopularPeopleResponseDTO] = []

            for try await response in group {
                responses.append(response)
            }

            return responses.sorted {
                $0.page < $1.page
            }
        }
    }

    private func filterBornTodayActors(_ people: [PersonDTO]) async -> [Actor] {

        let today = Date()
        let calendar = Calendar.current

        return await withTaskGroup(of: Actor?.self) { group in

            for person in people {
                group.addTask {
                    [
                        apiClient,
                        requestBuilder,
                        personMapper
                    ] in

                    do {
                        let request = try requestBuilder.build(for: .personDetails(personID: person.id))

                        let details: PersonDTO = try await apiClient.sendRequest(request)

                        guard let actor = personMapper.map(details),
                            let birthday = actor.birthday
                        else {
                            return nil
                        }

                        let birthdayComponents = calendar.dateComponents(
                            [.month, .day],
                            from: birthday
                        )

                        let todayComponents = calendar.dateComponents(
                            [.month, .day],
                            from: today
                        )

                        guard
                            birthdayComponents.month
                                == todayComponents.month,
                            birthdayComponents.day
                                == todayComponents.day
                        else {
                            return nil
                        }

                        return actor

                    } catch {
                        return nil
                    }
                }
            }

            var actors: [Actor] = []

            for await actor in group {
                if let actor {
                    actors.append(actor)
                }
            }

            return actors
        }
    }
}

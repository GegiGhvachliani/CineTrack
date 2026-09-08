//
//  AdvancedSearchFiltersSectionView.swift
//  Search
//

import SwiftUI

import DesignSystemTokens
import SearchDomain

struct AdvancedSearchFiltersSectionView: View {

    @Binding var filters: SearchFilters

    let onReset: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader
            ratingSection
            voteCountSection
            genresSection
            releaseYearSection
            runtimeSection
            regionSection
        }
    }

    // MARK: - Header

    private var sectionHeader: some View {
        HStack {

            Spacer()

            Button("Reset options", systemImage: "arrow.counterclockwise", action: onReset)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(ColorTokens.Brand.primary)
                .buttonStyle(.plain)
        }
    }

    // MARK: - Filter sections

    private var ratingSection: some View {
        filterCard {
            filterRow(title: "CineTrack Rating", values: Array(1...9)) { value in
                filters.minimumRating = filters.minimumRating == value ? nil : value
            } isSelected: { value in
                filters.minimumRating == value
            } label: { "\($0)+" }
        }
    }

    private var voteCountSection: some View {
        filterCard {
            filterRow(title: "Total Votes", values: [100, 500, 1_000, 3_000, 10_000]) { value in
                filters.minimumVoteCount = filters.minimumVoteCount == value ? nil : value
            } isSelected: { value in
                filters.minimumVoteCount == value
            } label: { "\($0.formatted())+ votes" }
        }
    }

    private var genresSection: some View {
        filterCard {
            filterRow(title: "Genres", values: Self.genres) { genre in
                if filters.genreIDs.contains(genre.id) {
                    filters.genreIDs.removeAll { $0 == genre.id }
                } else {
                    filters.genreIDs.append(genre.id)
                }
            } isSelected: { genre in
                filters.genreIDs.contains(genre.id)
            } label: { $0.name }
        }
    }

    private var releaseYearSection: some View {
        filterCard {
            filterRow(title: "Release Year", values: [2026, 2025, 2024, 2023, 2020, 2015, 2010, 2000]) { value in
                filters.releaseYear = filters.releaseYear == value ? nil : value
            } isSelected: { value in
                filters.releaseYear == value
            } label: { String($0) }
        }
    }

    private var runtimeSection: some View {
        filterCard {
            filterRow(title: "Runtime", values: Self.runtimeOptions) { option in
                if filters.minimumRuntime == option.minimum,
                   filters.maximumRuntime == option.maximum {
                    filters.minimumRuntime = nil
                    filters.maximumRuntime = nil
                } else {
                    filters.minimumRuntime = option.minimum
                    filters.maximumRuntime = option.maximum
                }
            } isSelected: { option in
                filters.minimumRuntime == option.minimum && filters.maximumRuntime == option.maximum
            } label: { $0.title }
        }
    }

    private var regionSection: some View {
        filterCard {
            filterRow(title: "Region", values: Self.regions) { region in
                filters.region = filters.region == region.code ? nil : region.code
            } isSelected: { region in
                filters.region == region.code
            } label: { $0.name }
        }
    }

    // MARK: - Reusable UI

    private func filterCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .padding(14)
            .background(.clear)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func filterRow<Value: Hashable>(
        title: String,
        values: [Value],
        onTap: @escaping (Value) -> Void,
        isSelected: @escaping (Value) -> Bool,
        label: @escaping (Value) -> String
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(ColorTokens.Text.main)

            ScrollView(.horizontal) {
                HStack(spacing: 9) {
                    ForEach(values, id: \.self) { value in
                        SearchFilterChip(
                            title: label(value),
                            isSelected: isSelected(value)
                        ) {
                            onTap(value)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

// MARK: - Filter options

private extension AdvancedSearchFiltersSectionView {

    struct Genre: Hashable {
        let id: Int
        let name: String
    }

    struct RuntimeOption: Hashable {
        let title: String
        let minimum: Int?
        let maximum: Int?
    }

    struct Region: Hashable {
        let code: String
        let name: String
    }

    static let genres = [
        Genre(id: 28, name: "Action"), Genre(id: 12, name: "Adventure"),
        Genre(id: 16, name: "Animation"), Genre(id: 35, name: "Comedy"),
        Genre(id: 80, name: "Crime"), Genre(id: 18, name: "Drama"),
        Genre(id: 10751, name: "Family"), Genre(id: 14, name: "Fantasy"),
        Genre(id: 27, name: "Horror"), Genre(id: 878, name: "Sci-Fi"),
        Genre(id: 53, name: "Thriller")
    ]

    static let runtimeOptions = [
        RuntimeOption(title: "Under 90 min", minimum: nil, maximum: 89),
        RuntimeOption(title: "90–120 min", minimum: 90, maximum: 120),
        RuntimeOption(title: "120–150 min", minimum: 120, maximum: 150),
        RuntimeOption(title: "150+ min", minimum: 150, maximum: nil)
    ]

    static let regions = [
        Region(code: "US", name: "United States"), Region(code: "GB", name: "United Kingdom"),
        Region(code: "GE", name: "Georgia"), Region(code: "FR", name: "France"),
        Region(code: "DE", name: "Germany"), Region(code: "JP", name: "Japan"),
        Region(code: "KR", name: "South Korea"), Region(code: "IN", name: "India")
    ]
}

#Preview {
    AdvancedSearchFiltersSectionView(
        filters: .constant(SearchFilters(genreIDs: [28, 878])),
        onReset: {}
    )
    .padding()
    .background(ColorTokens.Background.main)
}

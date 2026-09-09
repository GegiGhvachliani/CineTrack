//
//  AdvancedSearchFiltersSectionView.swift
//  Search
//

import SwiftUI
import Foundation

import DesignSystemTokens
import SearchDomain

struct AdvancedSearchFiltersSectionView: View {

    @Binding var filters: SearchFilters

    let onReset: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
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
            filterRow(
                title: "Total Votes",
                values: [100, 500, 1_000, 2_500, 5_000, 10_000, 25_000, 50_000, 100_000, 250_000, 500_000, 1_000_000]
            ) { value in
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
            rangeSection(title: "Release Year") {
                SearchRangeSlider(
                    bounds: Self.releaseYearBounds,
                    step: 1,
                    lowerTitle: releaseYearTitle,
                    upperTitle: releaseYearTitle,
                    lowerValue: releaseYearLowerBinding,
                    upperValue: releaseYearUpperBinding
                )
            }
        }
    }

    private var runtimeSection: some View {
        filterCard {
            rangeSection(title: "Runtime") {
                SearchRangeSlider(
                    bounds: Self.runtimeBounds,
                    step: 5,
                    lowerTitle: runtimeLowerTitle,
                    upperTitle: runtimeUpperTitle,
                    lowerValue: runtimeLowerBinding,
                    upperValue: runtimeUpperBinding
                )
            }
        }
    }

    private var regionSection: some View {
        filterCard {
            filterRow(title: "Production Region", values: Self.regions) { region in
                if filters.originCountryCodes.contains(region.code) {
                    filters.originCountryCodes.removeAll { $0 == region.code }
                } else {
                    filters.originCountryCodes.append(region.code)
                }
            } isSelected: { region in
                filters.originCountryCodes.contains(region.code)
            } label: { $0.name }
        }
    }

    // MARK: - Reusable UI

    private func filterCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .background(.clear)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func rangeSection<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(ColorTokens.Text.main)

            content()
        }
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

    // MARK: - Range bindings

    private var releaseYearLowerBinding: Binding<Int> {
        Binding(
            get: { filters.minimumReleaseYear ?? Self.releaseYearBounds.lowerBound },
            set: { filters.minimumReleaseYear = $0 == Self.releaseYearBounds.lowerBound ? nil : $0 }
        )
    }

    private var releaseYearUpperBinding: Binding<Int> {
        Binding(
            get: { filters.maximumReleaseYear ?? Self.releaseYearBounds.upperBound },
            set: { filters.maximumReleaseYear = $0 == Self.releaseYearBounds.upperBound ? nil : $0 }
        )
    }

    private var runtimeLowerBinding: Binding<Int> {
        Binding(
            get: { filters.minimumRuntime ?? Self.runtimeBounds.lowerBound },
            set: { filters.minimumRuntime = $0 == Self.runtimeBounds.lowerBound ? nil : $0 }
        )
    }

    private var runtimeUpperBinding: Binding<Int> {
        Binding(
            get: { filters.maximumRuntime ?? Self.runtimeBounds.upperBound },
            set: { filters.maximumRuntime = $0 == Self.runtimeBounds.upperBound ? nil : $0 }
        )
    }

    private func releaseYearTitle(_ year: Int) -> String {
        String(year)
    }

    private func runtimeLowerTitle(_ runtime: Int) -> String {
        runtime == Self.runtimeBounds.lowerBound ? "Any" : "\(runtime) min"
    }

    private func runtimeUpperTitle(_ runtime: Int) -> String {
        runtime == Self.runtimeBounds.upperBound ? "Any" : "\(runtime) min"
    }
}

// MARK: - Filter options

private extension AdvancedSearchFiltersSectionView {

    struct Genre: Hashable {
        let id: Int
        let name: String
    }

    struct Region: Hashable {
        let code: String
        let name: String
    }

    static let genres = [
        Genre(id: 28, name: "Action"), Genre(id: 12, name: "Adventure"),
        Genre(id: 16, name: "Animation"), Genre(id: 35, name: "Comedy"),
        Genre(id: 80, name: "Crime"), Genre(id: 99, name: "Documentary"),
        Genre(id: 18, name: "Drama"), Genre(id: 10751, name: "Family"),
        Genre(id: 14, name: "Fantasy"), Genre(id: 36, name: "History"),
        Genre(id: 27, name: "Horror"), Genre(id: 10402, name: "Music"),
        Genre(id: 9648, name: "Mystery"), Genre(id: 10749, name: "Romance"),
        Genre(id: 878, name: "Science Fiction"), Genre(id: 10770, name: "TV Movie"),
        Genre(id: 53, name: "Thriller"), Genre(id: 10752, name: "War"),
        Genre(id: 37, name: "Western")
    ]

    static let releaseYearBounds = 1900...Calendar.current.component(.year, from: .now)
    static let runtimeBounds = 0...360

    static let regions = [
        Region(code: "US", name: "United States"),
        Region(code: "IN", name: "India"),
        Region(code: "GB", name: "United Kingdom"),
        Region(code: "FR", name: "France"),
        Region(code: "JP", name: "Japan"),
        Region(code: "KR", name: "South Korea"),
        Region(code: "DE", name: "Germany"),
        Region(code: "IT", name: "Italy"),
        Region(code: "ES", name: "Spain"),
        Region(code: "CN", name: "China"),
        Region(code: "CA", name: "Canada"),
        Region(code: "AU", name: "Australia"),
        Region(code: "MX", name: "Mexico"),
        Region(code: "BR", name: "Brazil"),
        Region(code: "RU", name: "Russia"),
        Region(code: "HK", name: "Hong Kong"),
        Region(code: "SE", name: "Sweden"),
        Region(code: "DK", name: "Denmark"),
        Region(code: "NO", name: "Norway"),
        Region(code: "NL", name: "Netherlands"),
        Region(code: "BE", name: "Belgium"),
        Region(code: "CH", name: "Switzerland"),
        Region(code: "AT", name: "Austria"),
        Region(code: "IE", name: "Ireland"),
        Region(code: "NZ", name: "New Zealand"),
        Region(code: "AR", name: "Argentina"),
        Region(code: "TR", name: "Turkey"),
        Region(code: "TH", name: "Thailand"),
        Region(code: "ID", name: "Indonesia"),
        Region(code: "PH", name: "Philippines")
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

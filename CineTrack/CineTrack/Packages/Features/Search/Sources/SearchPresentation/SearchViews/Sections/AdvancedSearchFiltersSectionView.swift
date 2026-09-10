//
//  AdvancedSearchFiltersSectionView.swift
//  Search
//

import SwiftUI
import Foundation

import DesignSystemTokens
import SearchDomain

struct AdvancedSearchFiltersSectionView: View {

    // MARK: - Properties

    @Binding
    var filters: SearchFilters

    let onReset: () -> Void

    // MARK: - Body

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

            Button(SearchStrings.Content.resetOptions, systemImage: "arrow.counterclockwise", action: onReset)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(ColorTokens.Brand.primary)
                .buttonStyle(.plain)
        }
    }

    // MARK: - Filter sections

    private var ratingSection: some View {
        filterCard {
            filterRow(title: SearchStrings.Content.cineTrackRating, values: Array(1...9)) { value in
                filters.minimumRating = filters.minimumRating == value ? nil : value
            } isSelected: { value in
                filters.minimumRating == value
            } label: {
                "\($0)+"
            }
        }
    }

    private var voteCountSection: some View {
        filterCard {
            filterRow(
                title: SearchStrings.Content.totalVotes,
                values: [100, 500, 1_000, 2_500, 5_000, 10_000, 25_000, 50_000, 100_000, 250_000, 500_000, 1_000_000]
            ) { value in
                filters.minimumVoteCount = filters.minimumVoteCount == value ? nil : value
            } isSelected: { value in
                filters.minimumVoteCount == value
            } label: {
                SearchStrings.Format.votes(count: $0)
            }
        }
    }

    private var genresSection: some View {
        filterCard {
            filterRow(title: SearchStrings.Content.genres, values: Self.genres) { genre in
                if filters.genreIDs.contains(genre.id) {
                    filters.genreIDs.removeAll { $0 == genre.id }
                } else {
                    filters.genreIDs.append(genre.id)
                }
            } isSelected: { genre in
                filters.genreIDs.contains(genre.id)
            } label: {
                $0.name
            }
        }
    }

    private var releaseYearSection: some View {
        filterCard {
            rangeSection(title: SearchStrings.Content.releaseYear) {
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
            rangeSection(title: SearchStrings.Content.runtime) {
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
            filterRow(title: SearchStrings.Content.productionRegion, values: Self.regions) { region in
                if filters.originCountryCodes.contains(region.code) {
                    filters.originCountryCodes.removeAll { $0 == region.code }
                } else {
                    filters.originCountryCodes.append(region.code)
                }
            } isSelected: { region in
                filters.originCountryCodes.contains(region.code)
            } label: {
                $0.name
            }
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
        runtime == Self.runtimeBounds.lowerBound
            ? SearchStrings.Content.any : SearchStrings.Format.runtime(minutes: runtime)
    }

    private func runtimeUpperTitle(_ runtime: Int) -> String {
        runtime == Self.runtimeBounds.upperBound
            ? SearchStrings.Content.any : SearchStrings.Format.runtime(minutes: runtime)
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
        Genre(id: 28, name: SearchStrings.Content.action), Genre(id: 12, name: SearchStrings.Content.adventure),
        Genre(id: 16, name: SearchStrings.Content.animation), Genre(id: 35, name: SearchStrings.Content.comedy),
        Genre(id: 80, name: SearchStrings.Content.crime), Genre(id: 99, name: SearchStrings.Content.documentary),
        Genre(id: 18, name: SearchStrings.Content.drama), Genre(id: 10751, name: SearchStrings.Content.family),
        Genre(id: 14, name: SearchStrings.Content.fantasy), Genre(id: 36, name: SearchStrings.Content.history),
        Genre(id: 27, name: SearchStrings.Content.horror), Genre(id: 10402, name: SearchStrings.Content.music),
        Genre(id: 9648, name: SearchStrings.Content.mystery), Genre(id: 10749, name: SearchStrings.Content.romance),
        Genre(id: 878, name: SearchStrings.Content.scienceFiction),
        Genre(id: 10770, name: SearchStrings.Content.tvMovie),
        Genre(id: 53, name: SearchStrings.Content.thriller), Genre(id: 10752, name: SearchStrings.Content.war),
        Genre(id: 37, name: SearchStrings.Content.western)
    ]

    static let releaseYearBounds = 1900...Calendar.current.component(.year, from: .now)
    static let runtimeBounds = 0...360

    static let regions = [
        Region(code: "US", name: SearchStrings.Content.unitedStates),
        Region(code: "IN", name: SearchStrings.Content.india),
        Region(code: "GB", name: SearchStrings.Content.unitedKingdom),
        Region(code: "FR", name: SearchStrings.Content.france),
        Region(code: "JP", name: SearchStrings.Content.japan),
        Region(code: "KR", name: SearchStrings.Content.southKorea),
        Region(code: "DE", name: SearchStrings.Content.germany),
        Region(code: "IT", name: SearchStrings.Content.italy),
        Region(code: "ES", name: SearchStrings.Content.spain),
        Region(code: "CN", name: SearchStrings.Content.china),
        Region(code: "CA", name: SearchStrings.Content.canada),
        Region(code: "AU", name: SearchStrings.Content.australia),
        Region(code: "MX", name: SearchStrings.Content.mexico),
        Region(code: "BR", name: SearchStrings.Content.brazil),
        Region(code: "RU", name: SearchStrings.Content.russia),
        Region(code: "HK", name: SearchStrings.Content.hongKong),
        Region(code: "SE", name: SearchStrings.Content.sweden),
        Region(code: "DK", name: SearchStrings.Content.denmark),
        Region(code: "NO", name: SearchStrings.Content.norway),
        Region(code: "NL", name: SearchStrings.Content.netherlands),
        Region(code: "BE", name: SearchStrings.Content.belgium),
        Region(code: "CH", name: SearchStrings.Content.switzerland),
        Region(code: "AT", name: SearchStrings.Content.austria),
        Region(code: "IE", name: SearchStrings.Content.ireland),
        Region(code: "NZ", name: SearchStrings.Content.newZealand),
        Region(code: "AR", name: SearchStrings.Content.argentina),
        Region(code: "TR", name: SearchStrings.Content.turkey),
        Region(code: "TH", name: SearchStrings.Content.thailand),
        Region(code: "ID", name: SearchStrings.Content.indonesia),
        Region(code: "PH", name: SearchStrings.Content.philippines)
    ]
}

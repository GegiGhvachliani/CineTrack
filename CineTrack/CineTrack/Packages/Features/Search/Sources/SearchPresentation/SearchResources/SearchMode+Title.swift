import SearchDomain

extension SearchMode {

    // MARK: - Properties

    var title: String {
        switch self {
        case .recent:
            SearchStrings.Content.recent
        case .advanced:
            SearchStrings.Content.advanced
        }
    }
}

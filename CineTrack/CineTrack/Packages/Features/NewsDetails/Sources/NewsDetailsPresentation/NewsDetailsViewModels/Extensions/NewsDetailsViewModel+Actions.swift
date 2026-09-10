import Foundation
import Observation
import NewsDetailsDomain
import SharedCore

extension NewsDetailsViewModel {

    // MARK: - Actions

    public func didTapSource() {
        guard let articleURL else {
            return
        }

        onOpenSource?(articleURL)
    }
}

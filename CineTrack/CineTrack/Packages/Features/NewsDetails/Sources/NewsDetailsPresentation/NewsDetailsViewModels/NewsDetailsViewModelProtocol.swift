import Foundation
import Observation

import SharedCore

@MainActor
public protocol NewsDetailsViewModelProtocol: AnyObject, Observable {

    // MARK: - Content

    var news: News { get }
    var metadata: String { get }
    var sourceName: String { get }
    var articleURL: URL? { get }

    // MARK: - Actions

    func didTapSource()
}

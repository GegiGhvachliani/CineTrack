import Foundation
import SharedCore

public protocol NewsDetailsCoordinatorProtocol: Coordinator {
    func showSource(url: URL)
}

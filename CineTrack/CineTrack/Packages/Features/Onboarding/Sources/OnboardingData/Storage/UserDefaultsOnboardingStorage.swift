import Foundation

public final class UserDefaultsOnboardingStorage: OnboardingStorageProtocol, @unchecked Sendable {

    // MARK: - Dependencies

    private let defaults: UserDefaults
    private let completedKey = "hasCompletedOnboarding"

    // MARK: - Initialization

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    // MARK: - Storage

    public func isCompleted() -> Bool {
        defaults.bool(forKey: completedKey)
    }

    public func setCompleted() {
        defaults.set(true, forKey: completedKey)
    }
}

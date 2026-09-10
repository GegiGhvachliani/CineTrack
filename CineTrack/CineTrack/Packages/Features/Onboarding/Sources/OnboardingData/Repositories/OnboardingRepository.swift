import OnboardingDomain

public final class OnboardingRepository: OnboardingRepositoryProtocol {

    // MARK: - Dependencies

    private let storage: OnboardingStorageProtocol

    // MARK: - Initialization

    public init(storage: OnboardingStorageProtocol) {
        self.storage = storage
    }

    // MARK: - Onboarding

    public func saveOnboardingCompleted() {
        storage.setCompleted()
    }

    public func isOnboardingCompleted() -> Bool {
        storage.isCompleted()
    }
}

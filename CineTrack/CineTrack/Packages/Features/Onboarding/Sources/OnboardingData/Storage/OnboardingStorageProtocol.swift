public protocol OnboardingStorageProtocol: Sendable {
    func isCompleted() -> Bool
    func setCompleted()
}

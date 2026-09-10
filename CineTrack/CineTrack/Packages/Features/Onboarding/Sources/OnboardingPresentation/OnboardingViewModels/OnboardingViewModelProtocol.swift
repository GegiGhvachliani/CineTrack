import Observation
import OnboardingDomain

@MainActor
public protocol OnboardingViewModelProtocol: AnyObject, Observable {
    var currentStep: OnboardingStep { get }
    var isLastStep: Bool { get }

    func next()
    func finish()
}

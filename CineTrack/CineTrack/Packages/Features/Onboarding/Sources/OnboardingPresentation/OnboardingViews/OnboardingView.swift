//
//  OnboardingView.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 26/06/2026.
//

import SwiftUI

public struct OnboardingView<ViewModel: OnboardingViewModelProtocol>: View {

    // MARK: - Properties

    @State
    private var viewModel: ViewModel

    // MARK: - Initialization

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    public var body: some View {
        OnboardingPageView(page: viewModel.currentStep) {
            if viewModel.isLastStep {
                viewModel.finish()
            } else {
                viewModel.next()
            }
        }
    }
}

//
//  OnboardingView.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 26/06/2026.
//

import SwiftUI

public struct OnboardingView: View {
    @ObservedObject private var viewModel: OnboardingViewModel

    public init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }

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

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
        VStack(spacing: 32) {
            Spacer()
            
            Image(systemName: "film.stack.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
            
            VStack(spacing: 16) {
                Text("აღმოაჩინე კინოსამყარო")
                    .font(.system(size: 26, weight: .bold))
                    .multilineTextAlignment(.center)
                
                Text("CineTrack დაგეხმარება თვალი ადევნო შენს საყვარელ ფილმებსა და სერიალებს, შექმნა პირადი Watchlist და მართო პრეფერენციები.")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
            
            Spacer()
            
            Button(action: {
                viewModel.continuePressed()
            }) {
                Text("გაგრძელება")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background(Color.yellow)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 8)
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

#Preview {
    OnboardingView(viewModel: OnboardingViewModel(didComplete: {}))
}

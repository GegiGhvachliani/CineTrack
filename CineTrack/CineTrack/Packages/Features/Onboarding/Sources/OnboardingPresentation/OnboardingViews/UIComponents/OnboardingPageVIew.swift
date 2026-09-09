//
//  OnboardingPageVIew.swift
//  Onboarding
//
//  Created by Gegi Ghvachliani on 29/06/2026.
//

import DesignSystemTokens
import OnboardingDomain
import SwiftUI

public struct OnboardingPageView: View {
    
    let page: OnboardingStep
    let action: () -> Void
    
    public init(page: OnboardingStep, action: @escaping () -> Void) {
        self.page = page
        self.action = action
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                ColorTokens.Background.primary.ignoresSafeArea()
                
                VStack {
                    movieImageView
                    Spacer()
                }
                
                VStack(spacing: SpacingTokens.medium) {
                    appTitleView
                        .padding(.bottom)
                    discoverTitleView
                    discoverSubtitleView
                    
                    Spacer()
                    
                    buttonView
                }
                .frame(height: geometry.size.height * 0.80)
                .padding(.horizontal, SpacingTokens.medium)
                .frame(maxWidth: .infinity)
                .offset(y: 30)
                .background(
                    Rectangle()
                        .fill(ColorTokens.Background.primary)
                )
                
            }
        }
    }
    
    private var movieImageView: some View {
        Image(page.imageTitle, bundle: .module)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .ignoresSafeArea()
    }
    
    private var appTitleView: some View {
        Text(page.appTitle)
            .font(TypographyTokens.logo)
            .foregroundStyle(ColorTokens.Brand.primary)
            .frame(alignment: .center)
    }
    
    private var discoverTitleView: some View {
        Text(page.title)
            .font(TypographyTokens.title2)
            .foregroundStyle(ColorTokens.Text.main)
            .frame(alignment: .center)
    }
    
    private var discoverSubtitleView: some View {
        Text(page.subtitle)
            .font(TypographyTokens.body)
            .foregroundStyle(ColorTokens.Text.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal, SpacingTokens.large)
    }
    
    private var buttonView: some View {
        Button(action: action) {
            Text(page.buttonText)
                .font(TypographyTokens.headline)
                .foregroundStyle(ColorTokens.Background.primary)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(ColorTokens.Brand.primary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.bottom, 40)

        }
    }
}

#Preview {
    var action = { print(5)}
    OnboardingPageView(page: .preferences, action: action)
}

//
//  ButtonView.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 11/07/2026.
//

import SwiftUI
import DesignSystemTokens

public struct ButtonView: View {

    // MARK: - Properties

    public let title: String
    public let isLoading: Bool
    public let action: () -> Void

    // MARK: - Initialization

    public init(title: String, isLoading: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.isLoading = isLoading
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        Button {
            action()
        } label: {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: DesignSystemTokens.ColorTokens.Text.onBrand)
                        )
                } else {
                    Text(title)
                        .font(TypographyTokens.body)
                }
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(DesignSystemTokens.ColorTokens.Brand.primary)
            .foregroundStyle(DesignSystemTokens.ColorTokens.Text.onBrand)
            .cornerRadius(15)
        }
        .disabled(isLoading)
    }
}

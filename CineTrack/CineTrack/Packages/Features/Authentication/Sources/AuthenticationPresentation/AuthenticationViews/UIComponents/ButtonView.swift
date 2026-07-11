//
//  ButtonView.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 11/07/2026.
//

import SwiftUI
import DesignSystemTokens

public struct ButtonView: View {
    public let title: String
    public let isLoading: Bool
    public let action: () -> Void
    
    public init(title: String, isLoading: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.isLoading = isLoading
        self.action = action
    }
    
    public var body: some View {
        Button {
            action()
        } label: {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: DesignSystemTokens.ColorTokens.Text.inverse)
                        )
                } else {
                    Text(title)
                        .font(TypographyTokens.body)
                }
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(DesignSystemTokens.ColorTokens.Brand.primary)
            .foregroundStyle(DesignSystemTokens.ColorTokens.Text.inverse)
            .cornerRadius(15)
        }
        .disabled(isLoading)
    }
}


#Preview {
    VStack(spacing: 16) {
        ButtonView(title: "Sign In", action: {})
        ButtonView(title: "Sign In", isLoading: true, action: {})
    }
    .padding()
}

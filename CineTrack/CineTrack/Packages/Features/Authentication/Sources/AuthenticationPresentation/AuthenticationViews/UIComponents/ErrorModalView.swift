//
//  ErrorModalView.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 11/07/2026.
//

import SwiftUI
import DesignSystemTokens

struct ErrorModalView: View {

    // MARK: - Properties

    let message: String
    let onDismiss: () -> Void

    // MARK: - Body

    var body: some View {
        VStack(spacing: 15) {

            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 32))
                .foregroundStyle(.red)

            Text(message)
                .font(TypographyTokens.body)
                .foregroundStyle(ColorTokens.Text.primary)
                .multilineTextAlignment(.center)

            ButtonView(title: AuthenticationStrings.Content.okay) {
                onDismiss()
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(ColorTokens.Background.primary)
        )
    }
}

private struct ErrorModalModifier: ViewModifier {

    // MARK: - Properties

    @Binding
    var errorMessage: String?

    func body(content: Content) -> some View {
        ZStack {
            content

            if let message = errorMessage {
                Color.black
                    .opacity(0.35)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.25)) {
                            errorMessage = nil
                        }
                    }

                VStack {
                    Spacer()

                    ErrorModalView(message: message) {
                        withAnimation(.easeOut(duration: 0.25)) {
                            errorMessage = nil
                        }
                    }
                    .padding(15)
                }
                .transition(.move(edge: .bottom))
                .zIndex(1)
            }
        }
        .animation(.easeOut(duration: 0.25), value: errorMessage)
    }
}

extension View {
    func errorModal(message: Binding<String?>) -> some View {
        modifier(ErrorModalModifier(errorMessage: message))
    }
}

// MARK: - Preview

private struct ErrorModalPreviewContainer: View {

    // MARK: - Properties

    @State
    private var errorMessage: String? = AuthenticationStrings.Errors.userNotFound

    // MARK: - Body

    var body: some View {
        Color.gray.opacity(0.2)
            .ignoresSafeArea()
            .errorModal(message: $errorMessage)
    }
}

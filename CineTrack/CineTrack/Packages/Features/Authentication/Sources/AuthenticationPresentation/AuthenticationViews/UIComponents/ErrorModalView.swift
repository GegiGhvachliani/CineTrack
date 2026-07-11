//
//  ErrorModalView.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 11/07/2026.
//

import SwiftUI
import DesignSystemTokens

struct ErrorModalView: View {
    let message: String
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Capsule()
                .fill(ColorTokens.Text.secondary.opacity(0.3))
                .frame(width: 40, height: 5)
                .padding(.top, 10)

            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 32))
                .foregroundStyle(.red)

            Text(message)
                .font(TypographyTokens.body)
                .foregroundStyle(ColorTokens.Text.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)

            ButtonView(title: "OK") {
                onDismiss()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(ColorTokens.Background.primary)
        )
        .ignoresSafeArea(edges: .bottom)
    }
}

private struct ErrorModalModifier: ViewModifier {
    @Binding var errorMessage: String?

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
    @State private var errorMessage: String? = "This email address is not registered in our system."

    var body: some View {
        Color.gray.opacity(0.2)
            .ignoresSafeArea()
            .errorModal(message: $errorMessage)
    }
}

#Preview {
    ErrorModalPreviewContainer()
}

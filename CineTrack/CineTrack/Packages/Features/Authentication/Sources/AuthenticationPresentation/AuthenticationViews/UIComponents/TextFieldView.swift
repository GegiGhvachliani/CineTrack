//
//  TextFieldView.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 11/07/2026.
//

import SwiftUI
import DesignSystemTokens

public struct TextFieldView: View {

    // MARK: - Properties

    let title: String
    let icon: String
    @Binding
    var text: String
    @FocusState
    private var isFocused: Bool

    // MARK: - Initialization

    public init(title: String, icon: String, text: Binding<String>) {
        self.title = title
        self.icon = icon
        self._text = text
    }

    private var shouldFloat: Bool {
        isFocused || !text.isEmpty
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(isFocused ? ColorTokens.Text.primary : ColorTokens.Text.secondary)
                    .font(shouldFloat ? .caption : .body)
                    .offset(y: shouldFloat ? -45 : 0)
                    .offset(x: shouldFloat ? 0 : 50)
                    .scaleEffect(shouldFloat ? 0.95 : 1.0, anchor: .leading)

                HStack(spacing: 12) {
                    Image(systemName: icon)
                        .foregroundColor(ColorTokens.Text.secondary)
                        .frame(width: 24, height: 30)

                    TextField("", text: $text)
                        .focused($isFocused)
                        .textInputAutocapitalization(.words)
                        .foregroundColor(ColorTokens.Text.primary)
                        .textContentType(.none)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding(.horizontal)
            }
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(ColorTokens.Background.primary)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isFocused ? ColorTokens.Brand.primary : ColorTokens.Border.primary.opacity(0.5), lineWidth: 1.5)
            )
        }
        .animation(.easeOut(duration: 0.2), value: shouldFloat)
        .animation(.easeOut(duration: 0.2), value: isFocused)
    }
}

struct TextFieldViewPreviewContainer: View {

    // MARK: - Properties

    @State
    private var text = ""

    // MARK: - Body

    var body: some View {
        TextFieldView(title: AuthenticationStrings.SignUp.usernamePlaceholder, icon: "person.fill", text: $text)
            .padding()
            .background(ColorTokens.Background.main)
    }
}


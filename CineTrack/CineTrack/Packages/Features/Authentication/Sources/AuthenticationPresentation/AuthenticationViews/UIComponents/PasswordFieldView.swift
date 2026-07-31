//
//  PasswordFieldView.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 11/07/2026.
//

import SwiftUI
import DesignSystemTokens

public struct PasswordFieldView: View {
    @Binding var password: String
    @State private var isSecure = true
    @FocusState private var isFocused: Bool
    let title: String
    
    public init(password: Binding<String>, title: String) {
        self._password = password
        self.title = title
    }
    
    private var shouldFloat: Bool {
        isFocused || !password.isEmpty
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(isFocused ? ColorTokens.Text.primary : ColorTokens.Text.secondary)
                    .font(shouldFloat ? TypographyTokens.caption : TypographyTokens.body)
                    .offset(y: shouldFloat ? -45 : 0)
                    .offset(x: shouldFloat ? 0 : 50)
                    .scaleEffect(shouldFloat ? 0.95 : 1.0, anchor: .leading)
                
                HStack(spacing: SpacingTokens.medium) {
                    Image(systemName: "lock.fill")
                        .foregroundColor(ColorTokens.Text.secondary)
                        .frame(width: 24, height: 30)
                    
                    Group {
                        if isSecure {
                            SecureField("", text: $password)
                                .textContentType(.oneTimeCode)
                        } else {
                            TextField("", text: $password)
                                .textContentType(.oneTimeCode)
                        }
                    }
                    .focused($isFocused)
                    .foregroundColor(ColorTokens.Text.primary)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    
                    Button(action: { isSecure.toggle() }) {
                        Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(ColorTokens.Text.secondary)
                    }
                }
                .padding(.horizontal, SpacingTokens.regular)
            }
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(ColorTokens.Background.primary)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isFocused ? ColorTokens.Brand.primary : ColorTokens.Border.primary.opacity(0.5), lineWidth: 1.5)
            )
        }
        .animation(.easeOut(duration: 0.2), value: shouldFloat)
        .animation(.easeOut(duration: 0.2), value: isFocused)
    }
}

// MARK: - Preview
struct PasswordFieldViewPreviewContainer: View {
    @State private var password = ""
    
    var body: some View {
        PasswordFieldView(password: $password, title: "Password")
            .padding(SpacingTokens.regular)
            .background(ColorTokens.Background.main)
    }
}

#Preview {
    PasswordFieldViewPreviewContainer()
}

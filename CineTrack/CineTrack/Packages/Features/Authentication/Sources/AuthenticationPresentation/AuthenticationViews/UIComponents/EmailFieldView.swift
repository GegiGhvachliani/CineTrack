//
//  EmailFieldView.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 11/07/2026.
//

import SwiftUI
import DesignSystemTokens

public struct EmailFieldView: View {
    @Binding var email: String
    @FocusState private var isFocused: Bool
    let text: String
    
    public init(email: Binding<String>, text: String) {
        self._email = email
        self.text = text
    }
    
    private var shouldFloat: Bool {
        isFocused || !email.isEmpty
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .leading) {
                Text(text)
                    .foregroundColor(isFocused ? ColorTokens.Text.primary : ColorTokens.Text.secondary)
                    .font(shouldFloat ? .caption : .body)
                    .offset(y: shouldFloat ? -45 : 0)
                    .offset(x: shouldFloat ? 0 : 50)
                    .scaleEffect(shouldFloat ? 0.95 : 1.0, anchor: .leading)
                
                HStack(spacing: 12) {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(ColorTokens.Text.secondary)
                        .frame(width: 24, height: 30)
                    
                    TextField("", text: $email)
                        .focused($isFocused)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .foregroundColor(ColorTokens.Text.primary)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding()
            }
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

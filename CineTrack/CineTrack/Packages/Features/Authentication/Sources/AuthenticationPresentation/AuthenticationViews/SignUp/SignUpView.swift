//
//  SignUpView.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import SwiftUI

public struct SignUpView<ViewModel: SignUpViewModelProtocol>: View {
    
    // MARK: - Properties
    @StateObject private var viewModel: ViewModel
    private let onSignInTap: () -> Void
    
    // MARK: - Initializer
    public init(viewModel: ViewModel, onSignInTap: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSignInTap = onSignInTap
    }
    
    // MARK: - Body
    public var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header სექცია
                    VStack(spacing: 8) {
                        Text(AuthenticationStrings.SignUp.title)
                            .font(.largeTitle)
                            .bold()
                        
                        Text(AuthenticationStrings.SignUp.subtitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                    }
                    .padding(.top, 40)
                    
                    // Input ველები (მათ შორის Confirm Password)
                    VStack(spacing: 16) {
                        TextField(AuthenticationStrings.SignUp.usernamePlaceholder, text: $viewModel.username)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.username)
                            .autocapitalization(.none)
                        
                        TextField(AuthenticationStrings.SignUp.emailPlaceholder, text: $viewModel.email)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                        
                        SecureField(AuthenticationStrings.SignUp.passwordPlaceholder, text: $viewModel.password)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.newPassword)
                        
                        SecureField(AuthenticationStrings.SignUp.confirmPasswordPlaceholder, text: $viewModel.confirmPassword)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.newPassword)
                    }
                    .padding(.horizontal, 24)
                    
                    // ერორ მესიჯი (ვალიდაციის ან Firebase-ის ერორები)
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                    
                    // რეგისტრაციის ღილაკი
                    Button(action: {
                        Task {
                            await viewModel.signUpWithEmail()
                        }
                    }) {
                        HStack {
                            Spacer()
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text(AuthenticationStrings.SignUp.signUpButton)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                    .padding(.horizontal, 24)
                    .disabled(viewModel.isLoading)
                    
                    Spacer()
                    
                    // უკან დაბრუნება SignIn-ზე
                    HStack {
                        Text(AuthenticationStrings.SignUp.alreadyHaveAccount)
                            .foregroundColor(.secondary)
                        Button(action: onSignInTap) {
                            Text(AuthenticationStrings.SignUp.signInLink)
                                .bold()
                                .foregroundColor(.blue)
                        }
                    }
                    .font(.footnote)
                    .padding(.bottom, 20)
                }
            }
        }
    }
}

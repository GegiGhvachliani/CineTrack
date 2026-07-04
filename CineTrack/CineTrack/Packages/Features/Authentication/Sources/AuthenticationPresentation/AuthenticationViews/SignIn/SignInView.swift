//
//  SignInView.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import SwiftUI

public struct SignInView<ViewModel: SignInViewModelProtocol>: View {
    
    // MARK: - Properties
    @StateObject private var viewModel: ViewModel
    private let onSignUpTap: () -> Void
    
    // MARK: - Initializer
    public init(viewModel: ViewModel, onSignUpTap: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSignUpTap = onSignUpTap
    }
    
    // MARK: - Body
    public var body: some View {
        ZStack {
            // ფონი (აქ შენი დიზაინსისტემის ფერი ან ძირითადი ფონი ჩაჯდება)
            Color(.systemBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header სექცია
                    VStack(spacing: 8) {
                        Text(AuthenticationStrings.SignIn.title)
                            .font(.largeTitle)
                            .bold()
                        
                        Text(AuthenticationStrings.SignIn.subtitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                    }
                    .padding(.top, 40)
                    
                    // Input ველები
                    VStack(spacing: 16) {
                        TextField(AuthenticationStrings.SignIn.emailPlaceholder, text: $viewModel.email)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                        
                        SecureField(AuthenticationStrings.SignIn.passwordPlaceholder, text: $viewModel.password)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.password)
                    }
                    .padding(.horizontal, 24)
                    
                    // Forgot Password ბმული
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.isForgotPasswordPresented = true
                        }) {
                            Text(AuthenticationStrings.SignIn.forgotPasswordLink)
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // ერორ მესიჯი (თუ არსებობს)
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                    
                    // მთავარი ქმედების ღილაკები
                    VStack(spacing: 12) {
                        Button(action: {
                            Task {
                                await viewModel.signInWithEmail()
                            }
                        }) {
                            HStack {
                                Spacer()
                                if viewModel.isLoading && !viewModel.isForgotPasswordPresented {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                } else {
                                    Text(AuthenticationStrings.SignIn.signInButton)
                                        .bold()
                                        .foregroundColor(.white)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                        }
                        .disabled(viewModel.isLoading)
                        
                        // Google Sign-In ღილაკი
                        Button(action: {
                            Task {
                                await viewModel.signInWithGoogle()
                            }
                        }) {
                            HStack {
                                Image(systemName: "g.circle.fill") // დროებითი იკონკა, მერე asset-ით ჩაანაცვლებ
                                Text(AuthenticationStrings.SignIn.googleButton)
                                    .bold()
                            }
                            .foregroundColor(.primary)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                    
                    // გადასვლა SignUp-ზე
                    HStack {
                        Text(AuthenticationStrings.SignIn.dontHaveAccount)
                            .foregroundColor(.secondary)
                        Button(action: onSignUpTap) {
                            Text(AuthenticationStrings.SignIn.signUpLink)
                                .bold()
                                .foregroundColor(.blue)
                        }
                    }
                    .font(.footnote)
                    .padding(.bottom, 20)
                }
            }
        }
        // ქვემოდან ამომხტარი ფანჯარა პაროლის აღდგენისთვის
        .sheet(isPresented: $viewModel.isForgotPasswordPresented) {
            ForgotPasswordSheet(viewModel: viewModel)
                .presentationDetents([.medium]) // ზომა: ეკრანის ნახევარი
        }
    }
}

// MARK: - Forgot Password BottomSheet
struct ForgotPasswordSheet<ViewModel: SignInViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text(AuthenticationStrings.ForgotPassword.title)
                .font(.title2)
                .bold()
                .padding(.top, 24)
            
            Text(AuthenticationStrings.ForgotPassword.subtitle)
                .font(.footnote)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            TextField(AuthenticationStrings.ForgotPassword.emailPlaceholder, text: $viewModel.forgotPasswordEmail)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.horizontal, 24)
            
            if let successMessage = viewModel.forgotPasswordSuccessMessage {
                Text(successMessage)
                    .font(.caption)
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
            
            if let errorMessage = viewModel.forgotPasswordErrorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }
            
            Button(action: {
                Task {
                    await viewModel.sendResetPasswordLink()
                }
            }) {
                HStack {
                    Spacer()
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text(AuthenticationStrings.ForgotPassword.sendButton)
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
        }
    }
}

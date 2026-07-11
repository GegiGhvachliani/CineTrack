//
//  AuthenticationStrings.swift
//  Authentication
//
//  Created by Gegi Ghvachliani on 03/07/2026.
//

import Foundation

public enum AuthenticationStrings {
    
    // MARK: - SignIn
    public enum SignIn {
        public static let title = "Welcome Back"
        public static let subtitle = "Sign in to your account to continue tracking your favorite movies."
        public static let emailPlaceholder = "Email Address"
        public static let emailPlaceholderIcon = "envelope.fill"
        public static let passwordPlaceholder = "Password"
        public static let signInButton = "Sign In"
        public static let googleButton = "Continue with Google"
        public static let googleButtonIcon = "google"
        public static let forgotPasswordLink = "Forgot Password?"
        public static let dontHaveAccount = "Don't have an account? "
        public static let signUpLink = "Sign Up"
    }
    
    // MARK: - SignUp
    public enum SignUp {
        public static let title = "Create Account"
        public static let subtitle = "Sign up now and start building your personal cinematic universe."
        public static let usernamePlaceholder = "Username"
        public static let emailPlaceholder = "Email Address"
        public static let passwordPlaceholder = "Password"
        public static let confirmPasswordPlaceholder = "Confirm Password"
        public static let signUpButton = "Sign Up"
        public static let alreadyHaveAccount = "Already have an account? "
        public static let signInLink = "Sign In"
    }
    
    // MARK: - Forgot Password
    public enum ForgotPassword {
        public static let title = "Reset Password"
        public static let subtitle = "Enter your email address below and we will send you a link to reset your password."
        public static let emailPlaceholder = "Email Address"
        public static let sendButton = "Send Reset Link"
        public static let successMessage = "A password reset link has been sent to your email."
    }
    
    // MARK: - Validation & Firebase Errors
    public enum Errors {
        public static let emptyFields = "Please fill in all fields."
        public static let invalidEmail = "Please enter a valid email address."
        public static let emailAlreadyInUse = "This email address is already registered."
        public static let wrongPassword = "Incorrect password. Please try again."
        public static let shortPassword = "Password must be at least 6 characters and include one uppercase letter and one number."
        public static let passwordMismatch = "Passwords do not match. Please try again."
        public static let userNotFound = "This email address is not registered in our system."
        public static let generalError = "Something went wrong. Please try again."
    }
}

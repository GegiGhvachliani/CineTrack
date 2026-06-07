//
//  BaseViewModel.swift
//  SharedKit
//
//  Created by Gegi Ghvachliani on 06/06/2026.
//

import Foundation
import Combine

@MainActor
open class BaseViewModel: ObservableObject {
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String? = nil
    
    public func setLoading(_ loading: Bool) {
        self.isLoading = loading
    }
    public func setError(_ error: Error) {
        self.errorMessage = error.localizedDescription
    }
    public func clearError() {
        self.errorMessage = nil
    }
}

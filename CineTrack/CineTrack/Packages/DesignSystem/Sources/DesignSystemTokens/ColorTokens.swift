//
//  ColorTokens.swift
//  DesignSystem
//
//  Created by Gegi Ghvachliani on 27/06/2026.
//

import SwiftUI

public enum ColorTokens {
    
    public enum Background {
        public static let primary = Color("backgroundPrimary", bundle: .module)
        public static let secondary = Color("backgroundSecondary", bundle: .module)
    }
    
    public enum Text {
        public static let primary = Color("textPrimary", bundle: .module)
        public static let secondary = Color("textSecondary", bundle: .module)
        public static let inverse = Color("textInverse", bundle: .module)
    }
    
    public enum Brand {
        public static let primary = Color("brandPrimary", bundle: .module)
        public static let primaryPressed = Color("brandPrimaryPressed", bundle: .module)
    }
    
    public enum Border {
        public static let primary = Color("borderPrimary", bundle: .module)
    }
    
    public enum Status {
        public static let success = Color("success", bundle: .module)
        public static let warning = Color("warning", bundle: .module)
        public static let error = Color("error", bundle: .module)
    }
}

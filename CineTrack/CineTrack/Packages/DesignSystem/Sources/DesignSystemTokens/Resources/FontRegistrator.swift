//
//  FontRegistrator.swift
//  DesignSystem
//
//  Created by Gegi Ghvachliani on 28/06/2026.
//

import SwiftUI
import CoreText

public enum FontRegistrator {
    public static func registerCustomFonts() {
        registerFont(bundle: .module, fontName: "Impact", fontExtension: "ttf")
    }

    private static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            print("❌ Failed to register font: \(fontName)")
            return
        }
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            print("⚠️ Error registering font: \(fontName) - \(error.debugDescription)")
        }
    }
}

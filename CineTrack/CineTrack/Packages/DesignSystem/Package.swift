// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "DesignSystemComponents", targets: ["DesignSystemComponents"]),
        .library(name: "DesignSystemTokens", targets: ["DesignSystemTokens"])
    ],
    dependencies: [
        // SharedKit გვჭირდება მხოლოდ იმ შემთხვევაში, თუ კომპონენტები იყენებენ SharedCore-ის იუტილიტებს
        .package(path: "../SharedKit")
    ],
    targets: [
        .target(
            name: "DesignSystemTokens",
            dependencies: [],
            path: "Sources/DesignSystemTokens"
        ),
        
        .target(
            name: "DesignSystemComponents",
            dependencies: [
                "DesignSystemTokens",
                .product(name: "SharedCore", package: "SharedKit")  // თუ Layout/UI Helpers გჭირდება SharedCore-დან
            ],
            path: "Sources/DesignSystemComponents"
        ),
        
        .testTarget(
            name: "DesignSystemTests",
            dependencies: ["DesignSystemComponents", "DesignSystemTokens"],
            path: "Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

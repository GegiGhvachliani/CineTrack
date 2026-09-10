// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [.iOS(.v17)],
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
            path: "Sources/DesignSystemTokens",
            resources: [
                .process("Resources/DesignSystemAssets.xcassets")
            ]
        ),

        .target(
            name: "DesignSystemComponents",
            dependencies: [
                .product(name: "LibraryDomain", package: "SharedKit"),
                "DesignSystemTokens",
                .product(name: "SharedCore", package: "SharedKit")  // თუ Layout/UI Helpers გჭირდება SharedCore-დან
            ],
            path: "Sources/DesignSystemComponents",
            resources: [
                .process("Resources")
            ]
        ),

        .testTarget(
            name: "DesignSystemTests",
            dependencies: ["DesignSystemComponents", "DesignSystemTokens"],
            path: "Tests"
        )
    ],
    swiftLanguageModes: [.v6]
)

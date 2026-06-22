// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Onboarding",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "OnboardingAssembly", targets: ["OnboardingAssembly"])
    ],
    dependencies: [
        .package(path: "../SharedKit"),
        .package(path: "../DesignSystem"),
    ],
    targets: [
        .target(
            name: "OnboardingPresentation",
            dependencies: [
                .product(name: "SharedCore", package: "SharedKit"),  // კოორდინატორის პროტოკოლებისთვის
                .product(name: "DesignSystemComponents", package: "DesignSystem"),  // ღილაკებისთვის და ფონტებისთვის
            ],
            path: "Sources/OnboardingPresentation"
        ),

        .target(
            name: "OnboardingAssembly",
            dependencies: [
                "OnboardingPresentation"
            ],
            path: "Sources/OnboardingAssembly"
        ),

        .testTarget(
            name: "OnboardingTests",
            dependencies: ["OnboardingPresentation"],
            path: "Tests"
        ),
    ]
)

// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Onboarding",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "OnboardingPresentationAPI",
            targets: ["OnboardingPresentationAPI"]
        ),
        .library(name: "OnboardingAssembly", targets: ["OnboardingAssembly"])
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem")
    ],
    targets: [
        .target(
            name: "OnboardingDomain",
            dependencies: [],
            path: "Sources/OnboardingDomain"
        ),

        .target(
            name: "OnboardingData",
            dependencies: [
                "OnboardingDomain"
            ],
            path: "Sources/OnboardingData"
        ),

        .target(
            name: "OnboardingPresentation",
            dependencies: [
                .product(name: "DesignSystemTokens", package: "DesignSystem"),
                "OnboardingDomain",
                "OnboardingPresentationAPI",
                .product(name: "SharedCore", package: "SharedKit"),  // კოორდინატორის პროტოკოლებისთვის
                .product(
                    name: "DesignSystemComponents",
                    package: "DesignSystem"
                )  // ღილაკებისთვის და ფონტებისთვის
            ],
            path: "Sources/OnboardingPresentation",
            resources: [.process("OnboardingResources/OnboardingAssets.xcassets")]
        ),

        .target(
            name: "OnboardingPresentationAPI",
            dependencies: [
                "OnboardingDomain",
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/OnboardingPresentationAPI"
        ),

        .target(
            name: "OnboardingAssembly",
            dependencies: [
                "OnboardingDomain",
                "OnboardingData",
                "OnboardingPresentation",
                "OnboardingPresentationAPI"
            ],
            path: "Sources/OnboardingAssembly"
        ),

        .testTarget(
            name: "OnboardingTests",
            dependencies: ["OnboardingPresentation"],
            path: "Tests"
        )
    ]
)

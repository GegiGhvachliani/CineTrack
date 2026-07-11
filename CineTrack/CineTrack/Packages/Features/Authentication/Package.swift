// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Authentication",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "AuthenticationAssembly", targets: ["AuthenticationAssembly"]),
        .library(name: "AuthenticationPresentationAPI", targets: ["AuthenticationPresentationAPI"]),
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "12.1.0"),
        .package(url: "https://github.com/google/GoogleSignIn-iOS.git", from: "8.0.0")
    ],
    targets: [
        .target(
            name: "AuthenticationDomain",
            dependencies: [
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/AuthenticationDomain"
        ),

        .target(
            name: "AuthenticationData",
            dependencies: [
                "AuthenticationDomain",
                .product(name: "SharedNetworking", package: "SharedKit"),
                .product(name: "SharedStorage", package: "SharedKit"),
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS")
            ],
            path: "Sources/AuthenticationData"
        ),

        .target(
            name: "AuthenticationPresentation",
            dependencies: [
                "AuthenticationDomain",
                "AuthenticationData",
                "AuthenticationPresentationAPI",
                .product(name: "SharedCore", package: "SharedKit"),
                .product(name: "DesignSystemComponents", package: "DesignSystem"),
                .product(name: "DesignSystemTokens", package: "DesignSystem")
            ],
            path: "Sources/AuthenticationPresentation"
        ),

        .target(
            name: "AuthenticationPresentationAPI",
            dependencies: [
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/AuthenticationPresentationAPI"
        ),

        .target(
            name: "AuthenticationAssembly",
            dependencies: [
                "AuthenticationDomain",
                "AuthenticationData",
                "AuthenticationPresentation",
                "AuthenticationPresentationAPI",
            ],
            path: "Sources/AuthenticationAssembly"
        ),

        .testTarget(
            name: "AuthenticationTests",
            dependencies: [
                "AuthenticationDomain",
                "AuthenticationData",
                "AuthenticationPresentation",
            ],
            path: "Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

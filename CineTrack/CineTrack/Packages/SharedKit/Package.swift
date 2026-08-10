// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "SharedKit",
    platforms: [
        .iOS(.v17)
    ],

    products: [
        .library(
            name: "SharedCore",
            targets: ["SharedCore"]
        ),

        .library(
            name: "SharedNetworking",
            targets: ["SharedNetworking"]
        ),

        .library(
            name: "SharedStorage",
            targets: ["SharedStorage"]
        ),

        .library(
            name: "SharedAuth",
            targets: ["SharedAuth"]
        )
    ],

    dependencies: [
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            from: "12.1.0"
        )
    ],

    targets: [

        // MARK: - SharedCore

        .target(
            name: "SharedCore",
            dependencies: [],
            path: "Sources/SharedCore"
        ),

        // MARK: - SharedNetworking

        .target(
            name: "SharedNetworking",
            dependencies: [
                "SharedCore"
            ],
            path: "Sources/SharedNetworking"
        ),

        // MARK: - SharedStorage

        .target(
            name: "SharedStorage",
            dependencies: [
                "SharedCore",

                .product(
                    name: "FirebaseFirestore",
                    package: "firebase-ios-sdk"
                )
            ],
            path: "Sources/SharedStorage"
        ),

        // MARK: - SharedAuth

        .target(
            name: "SharedAuth",
            dependencies: [
                "SharedCore",
                "SharedStorage",

                .product(
                    name: "FirebaseAuth",
                    package: "firebase-ios-sdk"
                )
            ],
            path: "Sources/SharedAuth"
        ),

        // MARK: - Tests

        .testTarget(
            name: "SharedKitTests",
            dependencies: [
                "SharedCore",
                "SharedNetworking",
                "SharedStorage",
                "SharedAuth"
            ],
            path: "Tests"
        )
    ],

    swiftLanguageModes: [
        .v6
    ]
)

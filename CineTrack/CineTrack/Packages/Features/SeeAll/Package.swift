// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "SeeAll",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SeeAllPresentationAPI",
            targets: ["SeeAllPresentationAPI"]
        ),
        .library(
            name: "SeeAllAssembly",
            targets: ["SeeAllAssembly"]
        )
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem"),
        .package(path: "../../TMDBData")
    ],
    targets: [
        .target(
            name: "SeeAllDomain",
            dependencies: [
                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                )
            ],
            path: "Sources/SeeAllDomain"
        ),

        .target(
            name: "SeeAllData",
            dependencies: [
                "SeeAllDomain",

                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                ),
                .product(
                    name: "SharedNetworking",
                    package: "SharedKit"
                ),
                .product(
                    name: "TMDBData",
                    package: "TMDBData"
                )
            ],
            path: "Sources/SeeAllData"
        ),

        .target(
            name: "SeeAllPresentation",
            dependencies: [
                "SeeAllDomain",
                "SeeAllPresentationAPI",

                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                ),
                .product(
                    name: "DesignSystemComponents",
                    package: "DesignSystem"
                ),
                .product(
                    name: "DesignSystemTokens",
                    package: "DesignSystem"
                )
            ],
            path: "Sources/SeeAllPresentation"
        ),

        .target(
            name: "SeeAllPresentationAPI",
            dependencies: [
                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                )
            ],
            path: "Sources/SeeAllPresentationAPI"
        ),

        .target(
            name: "SeeAllAssembly",
            dependencies: [
                "SeeAllDomain",
                "SeeAllData",
                "SeeAllPresentation",
                "SeeAllPresentationAPI"
            ],
            path: "Sources/SeeAllAssembly"
        ),

        .testTarget(
            name: "SeeAllTests",
            dependencies: [
                "SeeAllDomain",
                "SeeAllData",
                "SeeAllPresentation"
            ],
            path: "Tests"
        )
    ],
    swiftLanguageModes: [.v6]
)

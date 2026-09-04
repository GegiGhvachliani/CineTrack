// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "NewsDetails",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "NewsDetailsPresentationAPI",
            targets: ["NewsDetailsPresentationAPI"]
        ),
        .library(
            name: "NewsDetailsAssembly",
            targets: ["NewsDetailsAssembly"]
        )
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem"),
        .package(path: "../../TMDBData")
    ],
    targets: [
        .target(
            name: "NewsDetailsDomain",
            dependencies: [
                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                )
            ],
            path: "Sources/NewsDetailsDomain"
        ),

        .target(
            name: "NewsDetailsData",
            dependencies: [
                "NewsDetailsDomain",

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
            path: "Sources/NewsDetailsData"
        ),

        .target(
            name: "NewsDetailsPresentation",
            dependencies: [
                "NewsDetailsDomain",
                "NewsDetailsPresentationAPI",

                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                ),
                .product(
                    name: "DesignSystemComponents",
                    package: "DesignSystem"
                )
            ],
            path: "Sources/NewsDetailsPresentation"
        ),

        .target(
            name: "NewsDetailsPresentationAPI",
            dependencies: [
                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                )
            ],
            path: "Sources/NewsDetailsPresentationAPI"
        ),

        .target(
            name: "NewsDetailsAssembly",
            dependencies: [
                "NewsDetailsDomain",
                "NewsDetailsData",
                "NewsDetailsPresentation",
                "NewsDetailsPresentationAPI"
            ],
            path: "Sources/NewsDetailsAssembly"
        ),

        .testTarget(
            name: "NewsDetailsTests",
            dependencies: [
                "NewsDetailsDomain",
                "NewsDetailsData",
                "NewsDetailsPresentation"
            ],
            path: "Tests"
        )
    ],
    swiftLanguageModes: [.v6]
)

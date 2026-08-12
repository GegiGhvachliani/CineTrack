// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "HomePresentationAPI",
            targets: ["HomePresentationAPI"]
        ),
        .library(
            name: "HomeAssembly",
            targets: ["HomeAssembly"]
        )
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem"),
        .package(path: "../../TMDBData"),
        .package(path: "../../NewsData")
    ],
    targets: [

        // MARK: - Domain

        .target(
            name: "HomeDomain",
            dependencies: [
                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                )
            ],
            path: "Sources/HomeDomain"
        ),

        // MARK: - Data

            .target(
                name: "HomeData",
                dependencies: [
                    "HomeDomain",

                    .product(
                        name: "SharedCore",
                        package: "SharedKit"
                    ),

                    .product(
                        name: "SharedNetworking",
                        package: "SharedKit"
                    ),

                    .product(
                        name: "SharedStorage",
                        package: "SharedKit"
                    ),

                    .product(
                        name: "SharedAuth",
                        package: "SharedKit"
                    ),

                    .product(
                        name: "TMDBData",
                        package: "TMDBData"
                    ),

                    .product(
                        name: "NewsData",
                        package: "NewsData"
                    )
                ],
                path: "Sources/HomeData"
            ),

        // MARK: - Presentation

        .target(
            name: "HomePresentation",
            dependencies: [
                "HomeDomain",
                "HomePresentationAPI",

                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                ),

                .product(
                    name: "DesignSystemComponents",
                    package: "DesignSystem"
                )
            ],
            path: "Sources/HomePresentation",
            resources: [
                .process("Resources")
            ]
        ),

        // MARK: - Presentation API

        .target(
            name: "HomePresentationAPI",
            dependencies: [
                "HomeDomain",
                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                )
            ],
            path: "Sources/HomePresentationAPI"
        ),

        // MARK: - Assembly

        .target(
            name: "HomeAssembly",
            dependencies: [
                "HomeDomain",
                "HomeData",
                "HomePresentation",
                "HomePresentationAPI",

                .product(
                    name: "SharedNetworking",
                    package: "SharedKit"
                ),

                .product(
                    name: "TMDBData",
                    package: "TMDBData"
                ),

                .product(
                    name: "NewsData",
                    package: "NewsData"
                )
            ],
            path: "Sources/HomeAssembly"
        ),

        // MARK: - Tests

        .testTarget(
            name: "HomeTests",
            dependencies: [
                "HomeDomain",
                "HomeData",
                "HomePresentation"
            ],
            path: "Tests"
        )
    ],
    swiftLanguageModes: [.v6]
)

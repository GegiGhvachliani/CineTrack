// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v17)],
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
        .package(path: "../TMDBData")
    ],
    targets: [
        
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
                        name: "TMDBData",
                        package: "TMDBData"
                    )
                ],
                path: "Sources/HomeData"
            ),
        
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
                resources: [                                    .process("Resources")
                    ]
            ),
        
            .target(
                name: "HomePresentationAPI",
                dependencies: [
                    .product(
                        name: "SharedCore",
                        package: "SharedKit"
                    )
                ],
                path: "Sources/HomePresentationAPI"
            ),
        
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
                    )
                ],
                path: "Sources/HomeAssembly"
            ),
        
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

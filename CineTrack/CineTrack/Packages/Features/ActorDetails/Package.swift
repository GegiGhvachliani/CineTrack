// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "ActorDetails",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "ActorDetailsPresentationAPI",
            targets: ["ActorDetailsPresentationAPI"]
        ),
        .library(
            name: "ActorDetailsAssembly",
            targets: ["ActorDetailsAssembly"]
        )
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem"),
        .package(path: "../../TMDBData")
    ],
    targets: [
        .target(
            name: "ActorDetailsDomain",
            dependencies: [
                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                )
            ],
            path: "Sources/ActorDetailsDomain"
        ),

        .target(
            name: "ActorDetailsData",
            dependencies: [
                "ActorDetailsDomain",

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
            path: "Sources/ActorDetailsData"
        ),

        .target(
            name: "ActorDetailsPresentation",
            dependencies: [
                "ActorDetailsDomain",
                "ActorDetailsPresentationAPI",

                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                ),
                .product(
                    name: "DesignSystemComponents",
                    package: "DesignSystem"
                )
            ],
            path: "Sources/ActorDetailsPresentation"
        ),

        .target(
            name: "ActorDetailsPresentationAPI",
            dependencies: [
                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                )
            ],
            path: "Sources/ActorDetailsPresentationAPI"
        ),

        .target(
            name: "ActorDetailsAssembly",
            dependencies: [
                "ActorDetailsDomain",
                "ActorDetailsData",
                "ActorDetailsPresentation",
                "ActorDetailsPresentationAPI"
            ],
            path: "Sources/ActorDetailsAssembly"
        ),

        .testTarget(
            name: "ActorDetailsTests",
            dependencies: [
                "ActorDetailsDomain",
                "ActorDetailsData",
                "ActorDetailsPresentation"
            ],
            path: "Tests"
        )
    ],
    swiftLanguageModes: [.v6]
)

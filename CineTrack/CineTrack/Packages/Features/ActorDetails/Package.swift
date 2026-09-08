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
        .package(path: "../ActorMedia"),
        .package(path: "../ActorVideos"),
        .package(path: "../../TMDBData"),
        .package(path: "../../NewsData")
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
                ),
                .product(
                    name: "NewsData",
                    package: "NewsData"
                ),
                .product(
                    name: "SharedStorage",
                    package: "SharedKit"
                ),
                .product(
                    name: "SharedAuth",
                    package: "SharedKit"
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
                ),
                .product(
                    name: "ActorMediaDomain",
                    package: "ActorMedia"
                ),
                .product(
                    name: "ActorVideosDomain",
                    package: "ActorVideos"
                ),
            ],
            path: "Sources/ActorDetailsPresentation"
        ),

        .target(
            name: "ActorDetailsPresentationAPI",
            dependencies: [
                "ActorDetailsDomain",
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
                "ActorDetailsPresentationAPI",

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
                    name: "ActorMediaData",
                    package: "ActorMedia"
                ),
                .product(
                    name: "ActorMediaDomain",
                    package: "ActorMedia"
                ),
                .product(
                    name: "ActorVideosData",
                    package: "ActorVideos"
                ),
                .product(
                    name: "ActorVideosDomain",
                    package: "ActorVideos"
                )
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

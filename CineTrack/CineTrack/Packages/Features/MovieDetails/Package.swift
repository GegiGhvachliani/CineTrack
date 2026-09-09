// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieDetails",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "MovieDetailsPresentationAPI", targets: ["MovieDetailsPresentationAPI"]),
        .library(
            name: "MovieDetailsAssembly",
            targets: ["MovieDetailsAssembly"]
        )
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem"),
        .package(path: "../../TMDBData"),
        .package(path: "../../NewsData"),
        .package(path: "../Home"),
    ],
    targets: [
        .target(
            name: "MovieDetailsDomain",
            dependencies: [
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/MovieDetailsDomain"
        ),

        .target(
            name: "MovieDetailsData",
            dependencies: [
                "MovieDetailsDomain",
                .product(name: "SharedNetworking", package: "SharedKit"),
                .product(name: "SharedStorage", package: "SharedKit"),
                .product(name: "SharedAuth", package: "SharedKit"),
                .product(name: "SharedCore", package: "SharedKit"),
                .product(name: "TMDBData", package: "TMDBData"),
                .product(name: "NewsData", package: "NewsData"),
            ],
            path: "Sources/MovieDetailsData"
        ),

        .target(
            name: "MovieDetailsPresentation",
            dependencies: [
                "MovieDetailsDomain",
                "MovieDetailsPresentationAPI",
                .product(name: "SharedCore", package: "SharedKit"),
                .product(
                    name: "DesignSystemComponents",
                    package: "DesignSystem"
                ),
                .product(
                    name: "DesignSystemTokens",
                    package: "DesignSystem"
                ),
            ],
            path: "Sources/MovieDetailsPresentation"
        ),

        .target(
            name: "MovieDetailsPresentationAPI",
            dependencies: [
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/MovieDetailsPresentationAPI"
        ),

        .target(
            name: "MovieDetailsAssembly",
            dependencies: [
                "MovieDetailsDomain",
                "MovieDetailsData",
                "MovieDetailsPresentation",
                "MovieDetailsPresentationAPI",
                .product(name: "SharedCore", package: "SharedKit"),
                .product(name: "SharedNetworking", package: "SharedKit"),
                .product(name: "SharedStorage", package: "SharedKit"),
                .product(name: "SharedAuth", package: "SharedKit"),
                .product(name: "TMDBData", package: "TMDBData"),
                .product(name: "NewsData", package: "NewsData"),
                .product(name: "HomeData", package: "Home"),
                .product(name: "HomeDomain", package: "Home")
            ],
            path: "Sources/MovieDetailsAssembly"
        ),

        .testTarget(
            name: "MovieDetailsTests",
            dependencies: [
                "MovieDetailsDomain",
                "MovieDetailsData",
                "MovieDetailsPresentation",
                "MovieDetailsPresentationAPI"
            ],
            path: "Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieDetail",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "MovieDetailPresentationAPI", targets: ["MovieDetailPresentationAPI"]),
        .library(
            name: "MovieDetailAssemby",
            targets: ["MovieDetailAssembly"]
        )
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem"),
    ],
    targets: [
        .target(
            name: "MovieDetailDomain",
            dependencies: [
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/MovieDetailDomain"
        ),

        .target(
            name: "MovieDetailData",
            dependencies: [
                "MovieDetailDomain",
                .product(name: "SharedNetworking", package: "SharedKit"),
                .product(name: "SharedStorage", package: "SharedKit"),
            ],
            path: "Sources/MovieDetailData"
        ),

        .target(
            name: "MovieDetailPresentation",
            dependencies: [
                "MovieDetailDomain",
                .product(name: "SharedCore", package: "SharedKit"),
                .product(
                    name: "DesignSystemComponents",
                    package: "DesignSystem"
                ),
            ],
            path: "Sources/MovieDetailPresentation"
        ),

        .target(
            name: "MovieDetailPresentationAPI",
            dependencies: [
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/MovieDetailPresentationAPI"
        ),

        .target(
            name: "MovieDetailAssembly",
            dependencies: [
                "MovieDetailDomain",
                "MovieDetailData",
                "MovieDetailPresentation",
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/MovieDetailAssembly"
        ),

        .testTarget(
            name: "MovieDetailTests",
            dependencies: [
                "MovieDetailDomain",
                "MovieDetailData",
                "MovieDetailPresentation",
                "MovieDetailPresentationAPI"
            ],
            path: "Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

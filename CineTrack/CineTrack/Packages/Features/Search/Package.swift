// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Search",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "SearchPresentationAPI", targets: ["SearchPresentationAPI"]),
        .library(name: "SearchAssembly", targets: ["SearchAssembly"])
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem"),
        .package(path: "../../TMDBData"),
        .package(path: "../../Home"),
    ],
    targets: [

        .target(
            name: "SearchDomain",
            dependencies: [
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/SearchDomain"
        ),

        .target(
            name: "SearchData",
            dependencies: [
                "SearchDomain",
                .product(name: "SharedNetworking", package: "SharedKit"),
                .product(name: "SharedStorage", package: "SharedKit"),
                .product(name: "SharedCore", package: "SharedKit"),
                .product(name: "TMDBData", package: "TMDBData"),
            ],
            path: "Sources/SearchData"
        ),

        .target(
            name: "SearchPresentation",
            dependencies: [
                "SearchDomain",
                "SearchPresentationAPI",
                .product(name: "SharedCore", package: "SharedKit"),
                .product(
                    name: "DesignSystemComponents",
                    package: "DesignSystem"
                ),
                .product(
                    name: "HomePresentation",
                    package: "Home"
                ),
            ],
            path: "Sources/SearchPresentation"
        ),

        .target(
            name: "SearchPresentationAPI",
            dependencies: [
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/SearchPresentationAPI"
        ),

        .target(
            name: "SearchAssembly",
            dependencies: [
                "SearchDomain",
                "SearchData",
                "SearchPresentation",
                "SearchPresentationAPI",
                .product(name: "SharedNetworking", package: "SharedKit"),
                .product(name: "TMDBData", package: "TMDBData")
            ],
            path: "Sources/SearchAssembly"
        ),

        .testTarget(
            name: "SearchTests",
            dependencies: [
                "SearchDomain",
                "SearchData",
                "SearchPresentation",
            ],
            path: "Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

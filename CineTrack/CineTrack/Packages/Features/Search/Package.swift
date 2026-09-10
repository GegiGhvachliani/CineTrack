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
        .package(path: "../../TMDBData")
    ],
    targets: [

        .target(
            name: "SearchDomain",
            dependencies: [
                .product(name: "LibraryDomain", package: "SharedKit"),
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
                .product(name: "TMDBData", package: "TMDBData")
            ],
            path: "Sources/SearchData"
        ),

        .target(
            name: "SearchPresentation",
            dependencies: [
                .product(name: "DesignSystemTokens", package: "DesignSystem"),
                .product(name: "LibraryDomain", package: "SharedKit"),
                "SearchDomain",
                "SearchPresentationAPI",
                .product(name: "SharedCore", package: "SharedKit"),
                .product(
                    name: "DesignSystemComponents",
                    package: "DesignSystem"
                )
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
                .product(name: "LibraryData", package: "SharedKit"),
                .product(name: "LibraryDomain", package: "SharedKit"),
                "SearchDomain",
                "SearchData",
                "SearchPresentation",
                "SearchPresentationAPI",
                .product(name: "SharedNetworking", package: "SharedKit"),
                .product(name: "TMDBData", package: "TMDBData"),
                .product(name: "SharedAuth", package: "SharedKit"),
                .product(name: "SharedStorage", package: "SharedKit")
            ],
            path: "Sources/SearchAssembly"
        ),

        .testTarget(
            name: "SearchTests",
            dependencies: [
                "SearchDomain",
                "SearchData",
                "SearchPresentation"
            ],
            path: "Tests"
        )
    ],
    swiftLanguageModes: [.v6]
)

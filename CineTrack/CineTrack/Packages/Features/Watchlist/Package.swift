// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Watchlist",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "WatchlistAssembly", targets: ["WatchlistAssembly"])
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem"),
    ],
    targets: [

        .target(
            name: "WatchlistDomain",
            dependencies: [
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/WatchlistDomain"
        ),

        .target(
            name: "WatchlistData",
            dependencies: [
                "WatchlistDomain",
                .product(name: "SharedNetworking", package: "SharedKit"),
                .product(name: "SharedStorage", package: "SharedKit"),
            ],
            path: "Sources/WatchlistData"
        ),

        .target(
            name: "WatchlistPresentation",
            dependencies: [
                "WatchlistDomain",
                .product(name: "SharedCore", package: "SharedKit"),
                .product(name: "DesignSystemComponents", package: "DesignSystem"),
            ],
            path: "Sources/WatchlistPresentation"
        ),

        .target(
            name: "WatchlistAssembly",
            dependencies: [
                "WatchlistDomain",
                "WatchlistData",
                "WatchlistPresentation",
            ],
            path: "Sources/WatchlistAssembly"
        ),

        .testTarget(
            name: "WatchlistTests",
            dependencies: [
                "WatchlistDomain",
                "WatchlistData",
                "WatchlistPresentation",
            ],
            path: "Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

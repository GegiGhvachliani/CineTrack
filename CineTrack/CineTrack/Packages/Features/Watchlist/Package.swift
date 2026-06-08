// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Watchlist",
    products: [
        .library(
            name: "Watchlist",
            targets: ["Watchlist"]
        ),
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem")
    ],
    targets: [
        .target(
            name: "Watchlist",
            dependencies: [
                "SharedKit",
                "DesignSystem"
            ]
        ),
        .testTarget(
            name: "WatchlistTests",
            dependencies: ["Watchlist"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieDetail",
    products: [
        .library(
            name: "MovieDetail",
            targets: ["MovieDetail"]
        ),
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem"),
    ],
    targets: [
        .target(
            name: "MovieDetail",
            dependencies: [
                "SharedKit",
                "DesignSystem"
            ]
        ),
        .testTarget(
            name: "MovieDetailTests",
            dependencies: ["MovieDetail"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

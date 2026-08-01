// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "TMDBData",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "TMDBData",
            targets: ["TMDBData"]
        )
    ],
    dependencies: [
        .package(path: "../../SharedKit")
    ],
    targets: [
        .target(
            name: "TMDBData",
            dependencies: [
                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                ),
                .product(
                    name: "SharedNetworking",
                    package: "SharedKit"
                )
            ],
            path: "Sources"
        )
    ],
    swiftLanguageModes: [.v6]
)

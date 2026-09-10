// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "NewsData",

    platforms: [
        .iOS(.v17)
    ],

    products: [
        .library(
            name: "NewsData",
            targets: ["NewsData"]
        )
    ],

    dependencies: [
        .package(path: "../SharedKit")
    ],

    targets: [

        .target(
            name: "NewsData",
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
        ),

        .testTarget(
            name: "NewsDataTests",
            dependencies: [
                "NewsData"
            ]
        )
    ],

    swiftLanguageModes: [.v6]
)

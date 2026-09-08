// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "ActorVideos",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "ActorVideosDomain", targets: ["ActorVideosDomain"]),
        .library(name: "ActorVideosData", targets: ["ActorVideosData"])
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../TMDBData")
    ],
    targets: [
        .target(
            name: "ActorVideosDomain",
            dependencies: [
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/ActorVideosDomain"
        ),
        .target(
            name: "ActorVideosData",
            dependencies: [
                "ActorVideosDomain",
                .product(name: "SharedNetworking", package: "SharedKit"),
                .product(name: "TMDBData", package: "TMDBData")
            ],
            path: "Sources/ActorVideosData"
        )
    ],
    swiftLanguageModes: [.v6]
)

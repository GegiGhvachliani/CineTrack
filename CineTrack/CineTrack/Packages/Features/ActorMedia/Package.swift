// swift-tools-version: 6.3
import PackageDescription

let package = Package(
    name: "ActorMedia",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "ActorMediaDomain", targets: ["ActorMediaDomain"]),
        .library(name: "ActorMediaData", targets: ["ActorMediaData"])
    ],
    dependencies: [
        .package(path: "../../SharedKit")
    ],
    targets: [
        .target(name: "ActorMediaDomain", path: "Sources/ActorMediaDomain"),
        .target(name: "ActorMediaData", dependencies: ["ActorMediaDomain", .product(name: "SharedNetworking", package: "SharedKit")], path: "Sources/ActorMediaData"),
    ],
    swiftLanguageModes: [.v6]
)

// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Profile",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "ProfileAssembly", targets: ["ProfileAssembly"])
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem"),
    ],
    targets: [

        .target(
            name: "ProfileDomain",
            dependencies: [
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/ProfileDomain"
        ),

        .target(
            name: "ProfileData",
            dependencies: [
                "ProfileDomain",
                .product(name: "SharedNetworking", package: "SharedKit"),
                .product(name: "SharedStorage", package: "SharedKit"),
            ],
            path: "Sources/ProfileData"
        ),

        .target(
            name: "ProfilePresentation",
            dependencies: [
                "ProfileDomain",
                .product(name: "SharedCore", package: "SharedKit"),
                .product(name: "DesignSystemComponents", package: "DesignSystem"),
            ],
            path: "Sources/ProfilePresentation"
        ),

        .target(
            name: "ProfileAssembly",
            dependencies: [
                "ProfileDomain",
                "ProfileData",
                "ProfilePresentation",
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/ProfileAssembly"
        ),

        .testTarget(
            name: "ProfileTests",
            dependencies: [
                "ProfileDomain",
                "ProfileData",
                "ProfilePresentation",
            ],
            path: "Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

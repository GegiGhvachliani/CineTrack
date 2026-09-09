// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Profile",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "ProfilePresentationAPI", targets: ["ProfilePresentationAPI"]),
        .library(name: "ProfileAssembly", targets: ["ProfileAssembly"])
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem"),
        .package(path: "../Home"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "12.1.0"),
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
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "SharedNetworking", package: "SharedKit"),
                .product(name: "SharedStorage", package: "SharedKit"),
            ],
            path: "Sources/ProfileData"
        ),

        .target(
            name: "ProfilePresentation",
            dependencies: [
                "ProfileDomain",
                "ProfilePresentationAPI",
                .product(name: "HomeDomain", package: "Home"),
                .product(name: "HomePresentation", package: "Home"),
                .product(name: "SharedCore", package: "SharedKit"),
                .product(
                    name: "DesignSystemComponents",
                    package: "DesignSystem"
                ),
            ],
            path: "Sources/ProfilePresentation"
        ),

        .target(
            name: "ProfilePresentationAPI",
            dependencies: [
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/ProfilePresentationAPI"
        ),

        .target(
            name: "ProfileAssembly",
            dependencies: [
                "ProfileDomain",
                "ProfileData",
                "ProfilePresentation",
                "ProfilePresentationAPI",
                .product(name: "HomeData", package: "Home"),
                .product(name: "SharedAuth", package: "SharedKit"),
                .product(name: "SharedStorage", package: "SharedKit"),
                .product(name: "SharedCore", package: "SharedKit"),
            ],
            path: "Sources/ProfileAssembly"
        ),

        .testTarget(
            name: "ProfileTests",
            dependencies: [
                "ProfileDomain",
                "ProfileData",
                "ProfilePresentation",
                "ProfilePresentationAPI",
                "ProfileAssembly"
            ],
            path: "Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

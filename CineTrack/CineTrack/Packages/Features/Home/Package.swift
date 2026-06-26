// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

// let package = Package(
//    name: "Home", // 1. იდენტიფიკატორი
//    platforms: [.iOS(.v16)],
//    products: [...],     // 2. რა გააქვს გარეთ (ვიტრინა)
//    dependencies: [...], // 3. რას ითხოვს გარედან (მომწოდებლები)
//    targets: [...]       // 4. შიდა სტრუქტურა (საამქრო)
// )

import PackageDescription

let package = Package(
    name: "Home",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "HomePresentationAPI", targets: ["HomePresentationAPI"]),
        .library(name: "HomeAssembly", targets: ["HomeAssembly"]),
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem"),
    ],
    targets: [

        .target(
            name: "HomeDomain",
            dependencies: [
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/HomeDomain"
        ),

        .target(
            name: "HomeData",
            dependencies: [
                "HomeDomain",
                .product(name: "SharedNetworking", package: "SharedKit"),
                .product(name: "SharedStorage", package: "SharedKit"),
            ],
            path: "Sources/HomeData"
        ),

        .target(
            name: "HomePresentation",
            dependencies: [
                "HomeDomain",
                "HomePresentationAPI",
                .product(name: "SharedCore", package: "SharedKit"),
                .product(
                    name: "DesignSystemComponents",
                    package: "DesignSystem"
                ),
            ],
            path: "Sources/HomePresentation"
        ),

        .target(
            name: "HomePresentationAPI",
            dependencies: [
                .product(name: "SharedCore", package: "SharedKit")
            ],
            path: "Sources/HomePresentationAPI"
        ),

        .target(
            name: "HomeAssembly",
            dependencies: [
                "HomeDomain",
                "HomeData",
                "HomePresentation",
                "HomePresentationAPI",
            ],
            path: "Sources/HomeAssembly"
        ),

        .testTarget(
            name: "HomeTests",
            dependencies: [
                "HomeDomain",
                "HomeData",
                "HomePresentation",
            ],
            path: "Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

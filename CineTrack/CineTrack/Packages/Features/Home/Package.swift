// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

//let package = Package(
//    name: "Home", // 1. იდენტიფიკატორი
//    platforms: [.iOS(.v16)],
//    products: [...],     // 2. რა გააქვს გარეთ (ვიტრინა)
//    dependencies: [...], // 3. რას ითხოვს გარედან (მომწოდებლები)
//    targets: [...]       // 4. შიდა სტრუქტურა (საამქრო)
//)

import PackageDescription

let package = Package(
    name: "Home",
    products: [
        .library(
            name: "Home",
            targets: ["Home"]
        ),
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../DesignSystem")
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
                "SharedKit",
                "DesignSystem"
            ]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

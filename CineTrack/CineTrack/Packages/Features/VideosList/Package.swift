// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "VideosList",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "VideosListPresentationAPI",
            targets: ["VideosListPresentationAPI"]
        ),
        .library(
            name: "VideosListAssembly",
            targets: ["VideosListAssembly"]
        )
    ],
    dependencies: [
        .package(path: "../../SharedKit"),
        .package(path: "../../DesignSystem"),
        .package(path: "../../TMDBData")
    ],
    targets: [
        .target(
            name: "VideosListDomain",
            dependencies: [
                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                )
            ],
            path: "Sources/VideosListDomain"
        ),

        .target(
            name: "VideosListData",
            dependencies: [
                "VideosListDomain",

                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                ),
                .product(
                    name: "SharedNetworking",
                    package: "SharedKit"
                ),
                .product(
                    name: "TMDBData",
                    package: "TMDBData"
                )
            ],
            path: "Sources/VideosListData"
        ),

        .target(
            name: "VideosListPresentation",
            dependencies: [
                "VideosListDomain",
                "VideosListPresentationAPI",

                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                ),
                .product(
                    name: "DesignSystemComponents",
                    package: "DesignSystem"
                )
            ],
            path: "Sources/VideosListPresentation"
        ),

        .target(
            name: "VideosListPresentationAPI",
            dependencies: [
                .product(
                    name: "SharedCore",
                    package: "SharedKit"
                )
            ],
            path: "Sources/VideosListPresentationAPI"
        ),

        .target(
            name: "VideosListAssembly",
            dependencies: [
                "VideosListDomain",
                "VideosListData",
                "VideosListPresentation",
                "VideosListPresentationAPI"
            ],
            path: "Sources/VideosListAssembly"
        ),

        .testTarget(
            name: "VideosListTests",
            dependencies: [
                "VideosListDomain",
                "VideosListData",
                "VideosListPresentation"
            ],
            path: "Tests"
        )
    ],
    swiftLanguageModes: [.v6]
)

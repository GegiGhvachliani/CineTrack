// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SharedKit",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "SharedCore", targets: ["SharedCore"]),
        .library(name: "SharedNetworking", targets: ["SharedNetworking"]),
        .library(name: "SharedStorage", targets: ["SharedStorage"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SharedCore",
            dependencies: [],
            path: "Sources/SharedCore"
        ),
        
        .target(
            name: "SharedNetworking",
            dependencies: [
                "SharedCore"
            ],
            path: "Sources/SharedNetworking"
        ),
        
        .target(
            name: "SharedStorage",
            dependencies: [
                "SharedCore" 
            ],
            path: "Sources/SharedStorage"
        ),
        
        // 4. TEST TARGET
        .testTarget(
            name: "SharedKitTests",
            dependencies: ["SharedCore", "SharedNetworking", "SharedStorage"],
            path: "Tests"
        )
    ],
   swiftLanguageModes: [.v6]
)

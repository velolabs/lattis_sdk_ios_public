// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LattisSDK",
    platforms: [
        .iOS(.v12),
        .watchOS(.v6),
        .macOS(.v10_13),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "LattisSDK",
            targets: ["LattisSDK"]),
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "LattisSDK",
            path: "LattisSDK.xcframework"
            )
    ]
)

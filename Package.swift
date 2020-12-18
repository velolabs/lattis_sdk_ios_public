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
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "LattisSDK",
//            type: .static,
            targets: ["LattisSDK"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "KeychainSwift", url: "https://github.com/evgenyneu/keychain-swift.git", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
//        .target(name: "LattisSDK", dependencies: ["LattisSDK"]),
        .binaryTarget(
            name: "LattisSDK",
            path: "LattisSDK.xcframework")
//            dependencies: [
//                .product(name: "KeychainSwift", package: "KeychainSwift")
//            ])
    ]
)
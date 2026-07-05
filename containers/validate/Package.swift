// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JiroTravelersMapContentsValidator",
    platforms: [.macOS(.v15)],
    products: [
        .executable(
            name: "jtmcvalidator",
            targets: ["JiroTravelersMapContentsValidator"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.8.2"),
        .package(url: "https://github.com/kylef/PathKit.git", from: "1.0.1"),
        .package(url: "https://github.com/417-72KI/JiroTravelersMap-Model", branch: "main"),
    ],
    targets: [
        .executableTarget(
            name: "JiroTravelersMapContentsValidator",
            dependencies: [
                "JiroTravelersMapContentsValidatorCore",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "PathKit",
                .product(name: "JiroTravelersMapModel", package: "JiroTravelersMap-Model"),
            ]
        ),
        .target(name: "JiroTravelersMapContentsValidatorCore"),
    ]
)

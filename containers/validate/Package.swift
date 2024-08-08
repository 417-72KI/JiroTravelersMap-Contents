// swift-tools-version:5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JiroTravelersMapContentsValidator",
    products: [
        .executable(
            name: "jtmcvalidator",
            targets: ["JiroTravelersMapContentsValidator"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
        .package(url: "https://github.com/kylef/PathKit.git", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "JiroTravelersMapContentsValidator",
            dependencies: [
                "JiroTravelersMapContentsValidatorCore",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "PathKit"
            ]
        ),
        .target(name: "JiroTravelersMapContentsValidatorCore"),
        .testTarget(
            name: "JiroTravelersMapContentsValidatorCoreTests",
            dependencies: ["JiroTravelersMapContentsValidatorCore"]
        ),
    ]
)

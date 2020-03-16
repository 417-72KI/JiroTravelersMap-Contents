// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JiroTravelersMapContentsValidator",
    products: [
        .executable(name: "jtmcvalidator", targets: ["JiroTravelersMapContentsValidator"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.0.1")),
        .package(url: "https://github.com/kylef/PathKit.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "JiroTravelersMapContentsValidator",
            dependencies: ["ArgumentParser", "PathKit"]),
        .testTarget(
            name: "JiroTravelersMapContentsValidatorTests",
            dependencies: ["JiroTravelersMapContentsValidator"]),
    ]
)

// swift-tools-version:6.2
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
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "PathKit",
                .product(name: "JiroTravelersMapModel", package: "JiroTravelersMap-Model"),
            ]
        ),
    ]
)

// MARK: -
extension SwiftSetting {
    static let existentialAny: Self = .enableUpcomingFeature("ExistentialAny")                                    // SE-0335, Swift 5.6,  SwiftPM 5.8+
    static let internalImportsByDefault: Self = .enableUpcomingFeature("InternalImportsByDefault")                // SE-0409, Swift 6.0,  SwiftPM 6.0+
    static let memberImportVisibility: Self = .enableUpcomingFeature("MemberImportVisibility")                    // SE-0444, Swift 6.1,  SwiftPM 6.1+
    static let inferIsolatedConformances: Self = .enableUpcomingFeature("InferIsolatedConformances")              // SE-0470, Swift 6.2,  SwiftPM 6.2+
    static let nonisolatedNonsendingByDefault: Self = .enableUpcomingFeature("NonisolatedNonsendingByDefault")    // SE-0461, Swift 6.2,  SwiftPM 6.2+
    static let immutableWeakCaptures: Self = .enableUpcomingFeature("ImmutableWeakCaptures")                      // SE-0481, Swift 6.2,  SwiftPM 6.2+
}

package.targets.forEach {
    $0.swiftSettings = [
        .existentialAny,
        .internalImportsByDefault,
        .memberImportVisibility,
        .inferIsolatedConformances,
        .nonisolatedNonsendingByDefault,
        .immutableWeakCaptures,
        .defaultIsolation(MainActor.self),
    ]
}

// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "RealtimeAPI",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "RealtimeAPI", targets: ["RealtimeAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/livekit/webrtc-xcframework.git", .upToNextMajor(from: "137.7151.10")),
        .package(url: "https://github.com/SwiftyLab/MetaCodable.git", .upToNextMajor(from: "1.5.0")),
    ],
    targets: [
        .target(name: "Core", dependencies: [
            .product(name: "MetaCodable", package: "MetaCodable"),
            .product(name: "HelperCoders", package: "MetaCodable")
        ]),
        .target(name: "UI", dependencies: ["Core", "WebRTC"]),
        .target(name: "RealtimeAPI", dependencies: ["Core", "WebRTC", "UI"]),
        .target(name: "WebRTC", dependencies: [
            "Core",
            .product(name: "LiveKitWebRTC", package: "webrtc-xcframework")
        ]),
    ]
)

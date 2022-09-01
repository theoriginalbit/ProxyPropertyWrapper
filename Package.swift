// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "ProxyPropertyWrapper",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(name: "ProxyPropertyWrapper", targets: ["ProxyPropertyWrapper"]),
    ],
    targets: [
        .target(name: "ProxyPropertyWrapper"),
        .testTarget(name: "ProxyPropertyWrapperTests", dependencies: ["ProxyPropertyWrapper"]),
    ]
)

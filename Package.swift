// swift-tools-version: 6.0

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
        .target(name: "ProxyPropertyWrapper", path: "Sources"),
        .testTarget(name: "ProxyPropertyWrapperTests", dependencies: ["ProxyPropertyWrapper"], path: "Tests"),
    ]
)

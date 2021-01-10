// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ITMulticastDelegate",
    products: [
        .library(name: "ITMulticastDelegate", targets: ["ITMulticastDelegate"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "ITMulticastDelegate", dependencies: []),
        .testTarget(name: "ITMulticastDelegateTests", dependencies: ["ITMulticastDelegate"]),
    ]
)

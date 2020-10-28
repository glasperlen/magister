// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Magister",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Magister",
            targets: ["Magister"]),
    ],
    targets: [
        .target(
            name: "Magister",
            path: "Sources"),
        .testTarget(
            name: "Tests",
            dependencies: ["Magister"],
            path: "Tests"),
    ]
)

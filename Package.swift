// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PropertyWrappers",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13)
    ],
    products: [
        .library(name: "PropertyWrappers", targets: ["PropertyWrappers"]),
    ],
    targets: [
        .target(name: "PropertyWrappers"),
        .testTarget(
            name: "PropertyWrappersTests",
            dependencies: ["PropertyWrappers"]),
    ]
)

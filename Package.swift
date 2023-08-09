// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PropertyWrappers",
    platforms: [
        .iOS(.v13),
        .macOS(.v11)
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

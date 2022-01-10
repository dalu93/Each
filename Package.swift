// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Each",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "Each",
            targets: ["Each"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Each",
            path: "Sources"
        ),
    ]
)

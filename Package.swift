// swift-tools-version:5.3

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
            path: "Sources",
            exclude: [
                "Info.plist",
            ],
            linkerSettings: [
                .linkedFramework("UIKit"),
            ]
        ),
    ]
)

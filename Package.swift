// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "TaskReceipt",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(
            name: "TaskReceipt",
            targets: ["TaskReceipt"]
        )
    ],
    targets: [
        .executableTarget(
            name: "TaskReceipt"
        )
    ]
)
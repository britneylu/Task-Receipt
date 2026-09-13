// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "ReceiptTodo",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(
            name: "ReceiptTodo",
            targets: ["ReceiptTodo"]
        )
    ],
    targets: [
        .executableTarget(
            name: "ReceiptTodo"
        )
    ]
)
// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JYCodable",
    products: [
        .library(
            name: "JYCodable",
            targets: ["JYCodable"]
        ),
    ],
    dependencies: [
        .package(url: "https://gitee.com/jy212/JYNameSpace.git", .upToNextMajor(from: "1.0.2")),
    ],
    targets: [
        .target(
            name: "JYCodable",
            dependencies: ["JYNameSpace"],
            path: "Sources"
        ),
    ]
)

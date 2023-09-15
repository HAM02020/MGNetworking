// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MGNetworking",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "MGNetworking",
            targets: ["MGNetworking"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.8.0")),
    ],
    targets: [
        .target(
            name: "MGNetworking",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
            ],
            path: "Sources"),
        .testTarget(
            name: "MGNetworkingTests",
            dependencies: ["MGNetworking"]),
    ]
)

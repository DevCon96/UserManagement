// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserManagement",
    products: [
        .library(
            name: "UserManagement",
            targets: ["UserManagement"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "UserManagement",
            dependencies: []),
        .testTarget(
            name: "UserManagementTests",
            dependencies: ["UserManagement"]),
    ]
)

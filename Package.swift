// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MaterialFormSwiftUI",
    platforms:  [.iOS(.v13), .tvOS(.v13)],
    products: [
        .library(
            name: "MaterialFormSwiftUI",
            targets: ["MaterialFormSwiftUI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/GirAppe/MaterialForm.git", .exact("0.9.6")),
    ],
    targets: [
        .target(
            name: "MaterialFormSwiftUI",
            dependencies: ["MaterialForm"]
        ),
        .testTarget(
            name: "MaterialFormSwiftUITests",
            dependencies: ["MaterialFormSwiftUI"]
        ),
    ]
)

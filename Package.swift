// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "hws_vapor_swift_fan_club",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMinor(from: "3.1.0")),
        .package(url: "https://github.com/vapor/leaf.git", .upToNextMinor(from: "3.0.0")),
        .package(url: "https://github.com/vapor/fluent-sqlite.git", .upToNextMinor(from: "3.0.0")),
        .package(url: "https://github.com/vapor/crypto.git", .upToNextMinor(from: "3.3.0"))
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "FluentSQLite", "Crypto", "Leaf"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"]),
    ]
)


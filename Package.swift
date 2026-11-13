// swift-tools-version:5.7
//
// A tiny SwiftPM package that depends on two libraries via SE-0292
// (Swift Package Registry) identity form `.package(id:)` instead of the
// classic SCM `.package(url:)` form. The registry it resolves against
// is configured in `.swiftpm/configuration/registries.json`.
//
// This repo shows Renovate detecting outdated SE-0292 registry-form
// dependencies and opening bump PRs (Renovate 44.234.0 or later).
import PackageDescription

let package = Package(
    name: "Demo",
    products: [
        .executable(name: "Demo", targets: ["Demo"]),
    ],
    dependencies: [
        // Both packages below are mirrored on the open Tuist Registry
        // (https://tuist.dev/api/registry/swift). The `scope.name`
        // identity maps to the upstream GitHub org/repo:
        //   apple.swift-argument-parser -> github.com/apple/swift-argument-parser
        //   apple.swift-log              -> github.com/apple/swift-log
        .package(id: "apple.swift-argument-parser", from: "1.0.0"),
        .package(id: "apple.swift-log",             from: "1.4.0"),
    ],
    targets: [
        .executableTarget(
            name: "Demo",
            dependencies: [
                .product(name: "ArgumentParser", package: "apple.swift-argument-parser"),
                .product(name: "Logging",        package: "apple.swift-log"),
            ]
        ),
    ]
)

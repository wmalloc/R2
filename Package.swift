// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "R2",
    platforms: [.iOS(.v15), .tvOS(.v15), .macOS(.v12), .watchOS(.v8), .macCatalyst(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "R2", targets: ["R2"]),
        .library(name: "R2Combine", targets: ["R2Combine"]),
        .library(name: "R2Concurrency", targets: ["R2Concurrency"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/wmalloc/WebService.git", .upToNextMajor(from: "0.5.9")),
        .package(url: "https://github.com/kortac/AWS4.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/CoreOffice/XMLCoder.git", .upToNextMajor(from: "0.15.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(name: "R2", dependencies: ["AWS4", "WebService", "XMLCoder"], path: "Sources/Core"),
        .target(name: "R2Combine", dependencies: ["R2", "AWS4", "WebService", "XMLCoder",
                                                      .product(name: "WebServiceCombine", package: "WebService")],
                path: "Sources/Combine"),
        .target(name: "R2Concurrency", dependencies: ["R2", "AWS4", "WebService", "XMLCoder",
                                                      .product(name: "WebServiceConcurrency", package: "WebService")],
                path: "Sources/Concurrency"),
        .testTarget(name: "R2Tests",
                    dependencies: ["R2", "XMLCoder",
                                   .product(name: "WebServiceURLMock", package: "WebService")],
                    resources: [
                        .copy("TestData")
                    ])
    ]
)

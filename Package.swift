// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "SwiftUIWebView",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(name: "SwiftUIWebView", targets: ["SwiftUIWebView"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "SwiftUIWebView", dependencies: []),
    ]
)

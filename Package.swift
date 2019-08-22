// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "MockImagePicker",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library( name: "MockImagePicker", targets: ["MockImagePicker"])
    ],
    dependencies: [
        .package(url: "https://github.com/yonat/SweeterSwift", from: "1.0.2")
    ],
    targets: [
        .target(name: "MockImagePicker", dependencies: ["SweeterSwift"], path: "Sources")
    ],
    swiftLanguageVersions: [.v5]
)

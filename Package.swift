// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.  

import PackageDescription

let package = Package(
    name: "UI",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "UI",
            targets: ["UI"]),
    ],
    dependencies: [
         .package(url: "https://github.com/freshOS/Stevia", from: "4.7.3"),
         .package(url: "https://github.com/LucasBighi/Utils", branch: "develop"),
    ],
    targets: [
        .target(
            name: "UI",
//            resources: [.process("Resources", localization: .default)],
            dependencies: [
                "Stevia",
                "Utils"
            ])
    ],
    swiftLanguageVersions: [.v4]
)

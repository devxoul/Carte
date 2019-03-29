// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "Carte",
  platforms: [
    .iOS(.v8),
  ],
  products: [
    .library(name: "Carte", targets: ["Carte"]),
  ],
  targets: [
    .target(name: "Carte"),
    .testTarget(name: "CarteTests", dependencies: ["Carte"]),
  ],
  swiftLanguageVersions: [.v4_2, .v5]
)

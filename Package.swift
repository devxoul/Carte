// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "Carte",
  products: [
    .library(name: "Carte", targets: ["Carte"]),
  ],
  targets: [
    .target(name: "Carte"),
    .testTarget(name: "CarteTests", dependencies: ["Carte"]),
  ]
)

// swift-tools-version:5.0

import PackageDescription



let package = Package(
  name: "Flitt",
  platforms: [.iOS(.v10)],
  products: [.library(name: "Flitt", targets: ["Cloudipsp"])],
  targets: [.target(name: "Cloudipsp", path: "Cloudipsp", publicHeadersPath: "")]
)

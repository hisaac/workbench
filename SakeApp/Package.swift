// swift-tools-version: 5.10

import CompilerPluginSupport
import PackageDescription

let package = Package(
	name: "SakeApp",
	platforms: [.macOS(.v10_15)],
	products: [
		.executable(name: "SakeApp", targets: ["SakeApp"]),
	],
	dependencies: [
		.package(url: "https://github.com/kattouf/Sake", from: "0.1.0"),
		.package(url: "https://github.com/kareman/SwiftShell", from: "5.1.0"),
	],
	targets: [
		.executableTarget(
			name: "SakeApp",
			dependencies: [
				"Sake",
				"SwiftShell",
			],
			path: "src/"
		),
	]
)

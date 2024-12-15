// swift-tools-version: 5.10

import PackageDescription

let package = Package(
	name: "Workbench",
	platforms: [
		.macOS(.v14)
	],
	products: [],
	dependencies: [
		.package(url: "https://github.com/tuist/Path", from: "0.3.8"),
		.package(url: "https://github.com/mxcl/Version", from: "2.1.0"),
	// 	.package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
	// 	.package(url: "https://github.com/SwiftyLab/MetaCodable", from: "1.4.0"),
	// 	.package(url: "https://github.com/tuist/Command", from: "0.9.32"),
	],
	targets: [
		.executableTarget(
			name: "Workbench",
			dependencies: [
				.target(name: "SysInfoKit"),
			],
			path: "src/Workbench/Sources"
		),
		.target(
			name: "SystemDefaults",
			path: "src/SystemDefaults/Sources"
		),
		.target(
			name: "SysInfoKit",
			dependencies: [
				.product(name: "Path", package: "Path"),
				.product(name: "Version", package: "Version"),
			],
			path: "src/SysInfoKit/Sources"
		),
		.testTarget(
			name: "SysInfoKitTests",
			dependencies: ["SysInfoKit"],
			path: "src/SysInfoKit/Tests"
		),
	]
)

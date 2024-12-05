// swift-tools-version: 5.10

import PackageDescription

let package = Package(
	name: "Workbench",
	platforms: [.macOS(.v14)],
	products: [
		.executable(name: "wb", targets: ["WorkbenchCLI"]),
		.library(name: "SystemDefaults", targets: ["SystemDefaults"]),
		.library(name: "SysInfoKit", targets: ["SysInfoKit"]),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
		.package(url: "https://github.com/mxcl/Version", from: "2.1.0"),
		.package(url: "https://github.com/SwiftyLab/MetaCodable", from: "1.4.0"),
		.package(url: "https://github.com/tuist/Command", from: "0.9.32"),
	],
	targets: [
		.executableTarget(
			name: "WorkbenchCLI",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.target(name: "SystemDefaults"),
			],
			path: "src/WorkBenchCLI/Sources"
		),

		.target(
			name: "SystemDefaults",
			path: "src/SystemDefaults/Sources"
		),

		.target(
			name: "SysInfoKit",
			dependencies: [
				.product(name: "Command", package: "Command"),
				.product(name: "MetaCodable", package: "MetaCodable"),
				.product(name: "Version", package: "Version"),
			],
			path: "src/SysInfoKit/Sources"
		),
		.testTarget(
			name: "SysInfoKitTests",
			dependencies: [
				.target(name: "SysInfoKit"),
			],
			path: "src/SysInfoKit/Tests"
		)
	]
)

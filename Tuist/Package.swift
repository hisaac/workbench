// swift-tools-version: 6.0

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
	targetSettings: [
		"PluginCore": ["SWIFT_VERSION": "5"]
	]
)

#endif

import PackageDescription

let package = Package(
	name: "SysInfoKit",
	dependencies: [
		.package(url: "https://github.com/SwiftyLab/MetaCodable", from: "1.4.0"),
		.package(url: "https://github.com/tuist/Command", from: "0.9.32"),
		.package(url: "https://github.com/mxcl/Version", from: "2.1.0"),
	]
)

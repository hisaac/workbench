// swift-tools-version: 5.10

import PackageDescription

// #if TUIST
// 	import ProjectDescription

// 	let packageSettings = PackageSettings(
// 		targetSettings: [
// 			"PluginCore": .settings(base: SettingsDictionary().swiftVersion("5")),
// 		]
// 	)

// #endif

let package = Package(
	name: "Workbench",
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
		.package(url: "https://github.com/mxcl/Version", from: "2.1.0"),
		.package(url: "https://github.com/SwiftyLab/MetaCodable", from: "1.4.0"),
		.package(url: "https://github.com/tuist/Command", from: "0.9.32"),
	]
)

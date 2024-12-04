import ProjectDescription

let swiftVersionFile = Path("//.config/.swift-version")
let swiftVersionFileContents = try! String(contentsOfFile: swiftVersionFile.pathString, encoding: .utf8)
let swiftVersionFileContentsTrimmed = swiftVersionFileContents.trimmingCharacters(in: .whitespacesAndNewlines)

let project = Project(
	name: "Workbench",
	settings: .settings(
		base: SettingsDictionary()
				.swiftVersion(swiftVersionFileContentsTrimmed)
				.otherSwiftFlags(["-warn-concurrency"])
	),
	targets: [
		.target(
			name: "WorkbenchCLI",
			destinations: .macOS,
			product: .commandLineTool,
			bundleId: "co.othr.WorkbenchCLI",
			sources: ["src/WorkbenchCLI/Sources/**"],
			dependencies: [
				.target(name: "SysInfoKit"),
				.target(name: "SystemDefaults"),
			]
		),

		.target(
			name: "SystemDefaults",
			destinations: .macOS,
			product: .framework,
			bundleId: "co.othr.SystemDefaults",
			sources: ["src/SystemDefaults/Sources/**"],
			dependencies: [
				.external(name: "MetaCodable"),
			]
		),

		.target(
			name: "SysInfoKit",
			destinations: .macOS,
			product: .framework,
			bundleId: "co.othr.SysInfoKit",
			sources: ["src/SysInfoKit/Sources/**"],
			dependencies: [
				.external(name: "Command"),
				.external(name: "MetaCodable"),
				.external(name: "Version"),
			]
		),
		.target(
			name: "SysInfoKitTests",
			destinations: .macOS,
			product: .unitTests,
			bundleId: "co.othr.SysInfoKit.Tests",
			sources: ["src/SysInfoKit/Tests/**"],
			resources: ["src/SysInfoKit/Tests/Resources/**"],
			dependencies: [
				.target(name: "SysInfoKit")
			]
		),
	]
)

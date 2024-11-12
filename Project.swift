import ProjectDescription

let swiftVersionFile = Path("//.config/.swift-version")
let swiftVersionFileContents = try! String(contentsOfFile: swiftVersionFile.pathString, encoding: .utf8)
let swiftVersionFileContentsTrimmed = swiftVersionFileContents.trimmingCharacters(in: .whitespacesAndNewlines)

let project = Project(
	name: "SysInfoKit",
	settings: .settings(
		base: SettingsDictionary().swiftVersion(swiftVersionFileContentsTrimmed)
	),
	targets: [
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
			bundleId: "co.othr.SysInfoKitTests",
			sources: ["src/SysInfoKit/Tests/**"],
			resources: ["src/SysInfoKit/Tests/Resources/**"],
			dependencies: [
				.target(name: "SysInfoKit")
			]
		),
	]
)

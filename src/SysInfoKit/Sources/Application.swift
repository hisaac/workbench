import AppKit
import Foundation
import Path
import Version

public struct Application {
	public let name: String
	public let version: Version
	public let bundleIdentifier: String
	public let path: AbsolutePath

	public init(
		name: String,
		version: Version,
		bundleIdentifier: String,
		path: AbsolutePath
	) {
		self.name = name
		self.version = version
		self.bundleIdentifier = bundleIdentifier
		self.path = path
	}
}

public extension Application {
	init(at path: AbsolutePath) throws {
		self.path = path

		let infoPlistPath = path.appending(components: "Contents", "Info.plist")
		let infoPlistContents = try Data(contentsOf: infoPlistPath)
		let infoPlist = try PropertyListDecoder().decode(ApplicationInfoPlist.self, from: infoPlistContents)

		self.name = infoPlist.name
		self.version = infoPlist.version
		self.bundleIdentifier = infoPlist.bundleIdentifier
	}

	init(with bundleIdentifier: String) throws {
		guard let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleIdentifier) else {
			throw NSError(domain: "ApplicationErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Application not found"])
		}
		let path = try AbsolutePath(validating: url.path())
		try self.init(at: path)
	}
}

public struct ApplicationInfoPlist: Decodable {
	public let name: String
	public let version: Version
	public let bundleIdentifier: String
}

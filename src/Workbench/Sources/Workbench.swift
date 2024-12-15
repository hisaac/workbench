import AppKit
import Foundation
import SysInfoKit

@main
struct Workbench {
	static func main() async throws {
		let installedXcodeVersions = try XcodeUtils.installedXcodeVersions()
		for xcode in installedXcodeVersions {
			print("Xcode at \(xcode.path) has version \(xcode.version)")
		}
	}
}

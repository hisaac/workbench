import AppKit
import Foundation
import SysInfoKit

@main
struct WorkbenchCLI {
	static func main() async throws {
		let workspace = NSWorkspace.shared
		let app = workspace.frontmostApplication
		print(app)
	}
}

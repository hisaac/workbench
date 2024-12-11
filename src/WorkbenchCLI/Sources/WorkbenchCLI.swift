import Foundation
import SysInfoKit
import SystemDefaults

@main
struct WorkbenchCLI {
	static func main() throws {
		let swVersCommand = sw_vers(productName: true)

		let process = Process()
		process.executableURL = swVersCommand.binary
		process.arguments = swVersCommand.arguments
		process.waitUntilExit()
		try process.run()

//		let homeDir = FileManager.default.homeDirectoryForCurrentUser.path()
		//		let val = CFPreferencesCopyValue(
		//			"" as CFString,
		//			"\(homeDir)/Library/Preferences/.GlobalPreferences.plist" as CFString,
		//			kCFPreferencesCurrentUser,
		//			kCFPreferencesCurrentHost
		//		)
//		let values = CFPreferencesCopyMultiple(
//			nil,
//			"\(homeDir)/Library/Preferences/.GlobalPreferences.plist" as CFString,
//			kCFPreferencesCurrentUser,
//			kCFPreferencesCurrentHost
//		)
//
//		for (key, value) in values as! [String: Any] {
//			print("\(key): \(value)")
//		}

		//		let kCFPreferencesGlobal = ".GlobalPreferences" as CFString
		//
		//		// Now try to get all keys
		//		if let keyList = CFPreferencesCopyKeyList(
		//			kCFPreferencesGlobal,
		//			kCFPreferencesAnyUser,
		//			kCFPreferencesAnyHost
		//		) as? [String] {
		//			print("\nFound \(keyList.count) keys:")
		//
		//			dump(keyList)
		//
		//			// for key in keyList {
		//			// 	if let value = CFPreferencesCopyAppValue(key as CFString, ".GlobalPreferences" as CFString) {
		//			// 		print("\(key): \(value)")
		//			// 	}
		//			// }
		//		} else {
		//			print("No keys found or error accessing preferences")
		//		}
	}
}

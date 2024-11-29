import Foundation

@main
struct WorkbenchCLI {
	static func main() {
		let kCFPreferencesGlobal = ".GlobalPreferences" as CFString

		// Now try to get all keys
		if let keyList = CFPreferencesCopyKeyList(
			kCFPreferencesGlobal,
			kCFPreferencesAnyUser,
			kCFPreferencesAnyHost
		) as? [String] {
			print("\nFound \(keyList.count) keys:")

			dump(keyList)

			// for key in keyList {
			// 	if let value = CFPreferencesCopyAppValue(key as CFString, ".GlobalPreferences" as CFString) {
			// 		print("\(key): \(value)")
			// 	}
			// }
		} else {
			print("No keys found or error accessing preferences")
		}
	}
}

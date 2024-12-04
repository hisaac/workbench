import Foundation
import SystemDefaults

// NSGlobalDomain and .GlobalPreferences and $HOME/Library/Preferences/.GlobalPreferences.plist are all the same thing
// Truly global preferences are stored in /Library/Preferences/.GlobalPreferences.plist

@main
struct WorkbenchCLI {
	static func main() {
		let homeDir = FileManager.default.homeDirectoryForCurrentUser.path()
		let val = CFPreferencesCopyValue(
			"NSDocumentSaveNewDocumentsToCloud" as CFString,
			"\(homeDir)/Library/Preferences/.GlobalPreferences.plist" as CFString,
			kCFPreferencesAnyUser,
			kCFPreferencesCurrentHost
		)
		print(val ?? "no value")

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

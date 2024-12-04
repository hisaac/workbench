#!/usr/bin/swift

import Foundation

let val = CFPreferencesCopyValue(
	"NSDocumentSaveNewDocumentsToCloud" as CFString,
	".GlobalPreferences" as CFString,
	kCFPreferencesAnyUser,
	kCFPreferencesAnyHost
)
print(val ?? "no value")

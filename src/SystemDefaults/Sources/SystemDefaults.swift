import Foundation

public typealias PropertyListValue = CFPropertyList

public struct SystemDefaults {
	public static let standard = SystemDefaults()

	public func object(
		for key: String,
		domain: String,
		user: String,
		host: String
	) -> PropertyListValue? {
		CFPreferencesCopyValue(
			key as CFString,
			domain as CFString,
			user as CFString,
			host as CFString
		)
	}

	public func set(
		_ value: PropertyListValue?,
		for key: String,
		domain: String,
		user: String,
		host: String
	) {
		CFPreferencesSetValue(
			key as CFString,
			value as PropertyListValue,
			domain as CFString,
			user as CFString,
			host as CFString
		)
		synchronize(domain: domain)
	}

	public func removeObject(
		for key: String,
		domain: String,
		user: String,
		host: String
	) {
		CFPreferencesSetValue(
			key as CFString,
			nil,
			domain as CFString,
			user as CFString,
			host as CFString
		)
		synchronize(domain: domain)
	}

	@discardableResult
	public func synchronize(domain: String) -> Bool {
		CFPreferencesAppSynchronize(domain as CFString)
	}
}

extension SystemDefaults {
	private static let userHomeDirectory = FileManager.default.homeDirectoryForCurrentUser

	public static let userGlobalDomain = userHomeDirectory.appending(
		path: "Library/Preferences/.GlobalPreferences.plist"
	).path()
	public static let userGlobalDomain_m = userHomeDirectory.appending(
		path: "Library/Preferences/.GlobalPreferences_m.plist"
	).path()
	public static var userGlobalDomain_ByHost: String? {
		let byHostDirectory = userHomeDirectory.appending(path: "Library/Preferences/ByHost")
		guard
			let byHostContents = try? FileManager.default.contentsOfDirectory(atPath: byHostDirectory.path()),
			let byHostFile = byHostContents.first(where: { $0.hasPrefix(".GlobalPreferences.") })
		else {
			return nil
		}
		return byHostDirectory.appending(path: byHostFile).path()
	}

	public static let systemGlobalDomain = "/Library/Preferences/.GlobalPreferences.plist"

	public static let anyApplication = kCFPreferencesAnyApplication as String
	public static let currentApplication = kCFPreferencesCurrentApplication as String
	public static let anyHost = kCFPreferencesAnyHost as String
	public static let currentHost = kCFPreferencesCurrentHost as String
	public static let anyUser = kCFPreferencesAnyUser as String
	public static let currentUser = kCFPreferencesCurrentUser as String
}

//public typealias PropertyList = [String: PropertyListValue]
//public protocol PropertyListValue {}
//
//// "Common" types
//extension String: PropertyListValue {}
//extension Data: PropertyListValue {}
//extension Date: PropertyListValue {}
//extension Bool: PropertyListValue {}
//
//// Numeric types
//extension Double: PropertyListValue {}
//extension Float: PropertyListValue {}
//extension CGFloat: PropertyListValue {}
//extension Int: PropertyListValue {}
//extension Int8: PropertyListValue {}
//extension UInt8: PropertyListValue {}
//extension Int16: PropertyListValue {}
//extension UInt16: PropertyListValue {}
//extension Int32: PropertyListValue {}
//extension UInt32: PropertyListValue {}
//extension Int64: PropertyListValue {}
//extension UInt64: PropertyListValue {}
//extension NSNumber: PropertyListValue {}
//
//// Collection types
//extension Array: PropertyListValue where Element: PropertyListValue {}
//extension Dictionary: PropertyListValue
//where Key == String, Value: PropertyListValue {}

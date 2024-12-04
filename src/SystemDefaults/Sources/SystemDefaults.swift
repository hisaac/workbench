import Foundation

public typealias PropertyListValue = CFPropertyList

public struct SystemDefaults {
	public static let standard = SystemDefaults()

	public func object(
		for key: String,
		domain: String = SystemDefaults.globalDomain
	) -> PropertyListValue? {
		CFPreferencesCopyValue(
			key as CFString,
			domain as CFString,
			SystemDefaults.currentUser as CFString,
			SystemDefaults.currentHost as CFString
		)
	}

	public func set(
		_ value: PropertyListValue,
		for key: String,
		domain: String = SystemDefaults.globalDomain
	) {
		CFPreferencesSetValue(
			key as CFString,
			value as PropertyListValue,
			domain as CFString,
			SystemDefaults.anyUser as CFString,
			SystemDefaults.anyHost as CFString
		)
		synchronize(domain: domain)
	}

	public func removeObject(
		for key: String,
		domain: String = SystemDefaults.globalDomain
	) {
		CFPreferencesSetValue(
			key as CFString,
			nil,
			domain as CFString,
			SystemDefaults.anyUser as CFString,
			SystemDefaults.anyHost as CFString
		)
		synchronize(domain: domain)
	}

	@discardableResult
	public func synchronize(domain: String = SystemDefaults.globalDomain) -> Bool {
		CFPreferencesAppSynchronize(domain as CFString)
	}
}

extension SystemDefaults {
	public static let globalDomain = ".GlobalPreferences"

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

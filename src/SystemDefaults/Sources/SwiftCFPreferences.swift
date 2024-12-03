import Foundation
import CoreFoundation

//public typealias PropertyList = [String: PropertyListValue]
//public protocol PropertyListValue {}
//extension String: PropertyListValue {}
//extension Int: PropertyListValue {}
//extension Double: PropertyListValue {}
//extension Bool: PropertyListValue {}
//extension Data: PropertyListValue {}
//extension Array: PropertyListValue where Element: PropertyListValue {}
//extension Dictionary: PropertyListValue where Key == String, Value: PropertyListValue {}
//
//public struct Preferences {
//	public static let kGlobalPreferences = ".GlobalPreferences"
//
//	public static let kAnyApplication = kCFPreferencesAnyApplication as String
//	public static let kCurrentApplication = kCFPreferencesCurrentApplication as String
//	public static let kAnyHost = kCFPreferencesAnyHost as String
//	public static let kCurrentHost = kCFPreferencesCurrentHost as String
//	public static let kAnyUser = kCFPreferencesAnyUser as String
//	public static let kCurrentUser = kCFPreferencesCurrentUser as String
//
//	public static func copyAppValue(key: String, applicationID: String = kGlobalPreferences) -> PropertyList {
//		return CFPreferencesCopyAppValue(
//			key as CFString,
//			applicationID as CFString
//		) as! PropertyList
//	}

//	func CFPreferencesGetAppBooleanValue(_ key: CFString, _ applicationID: CFString, _ keyExistsAndHasValidFormat: UnsafeMutablePointer<DarwinBoolean>?) -> Bool
//	func CFPreferencesGetAppIntegerValue(_ key: CFString, _ applicationID: CFString, _ keyExistsAndHasValidFormat: UnsafeMutablePointer<DarwinBoolean>?) -> CFIndex
//	func CFPreferencesSetAppValue(_ key: CFString, _ value: CFPropertyList?, _ applicationID: CFString)
//	func CFPreferencesAddSuitePreferencesToApp(_ applicationID: CFString, _ suiteID: CFString)
//	func CFPreferencesRemoveSuitePreferencesFromApp(_ applicationID: CFString, _ suiteID: CFString)
//	func CFPreferencesAppSynchronize(_ applicationID: CFString) -> Bool
//	func CFPreferencesCopyValue(_ key: CFString, _ applicationID: CFString, _ userName: CFString, _ hostName: CFString) -> CFPropertyList?
//	func CFPreferencesCopyMultiple(_ keysToFetch: CFArray?, _ applicationID: CFString, _ userName: CFString, _ hostName: CFString) -> CFDictionary
//	func CFPreferencesSetValue(_ key: CFString, _ value: CFPropertyList?, _ applicationID: CFString, _ userName: CFString, _ hostName: CFString)
//	func CFPreferencesSetMultiple(_ keysToSet: CFDictionary?, _ keysToRemove: CFArray?, _ applicationID: CFString, _ userName: CFString, _ hostName: CFString)
//	func CFPreferencesSynchronize(_ applicationID: CFString, _ userName: CFString, _ hostName: CFString) -> Bool
//	func CFPreferencesCopyKeyList(_ applicationID: CFString, _ userName: CFString, _ hostName: CFString) -> CFArray?
//	func CFPreferencesAppValueIsForced(_ key: CFString, _ applicationID: CFString) -> Bool
//}

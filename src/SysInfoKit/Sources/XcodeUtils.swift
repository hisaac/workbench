import CoreServices
import Foundation
import Path
import Version

enum MDQueryError: Error {
	case queryCreateError
	case queryExecuteError
}

enum XcodeUtilsError: Error {
	case plistCFBundleShortStringNotFound
	case unableToParseXcodeVersionString
}

struct Xcode: Codable {
	let path: AbsolutePath
	let version: Version
}

enum XcodeUtils {
	static func installedXcodeVersions() throws -> [Xcode] {
		let queryString = "kMDItemCFBundleIdentifier == 'com.apple.dt.Xcode'"
		guard let query = MDQueryCreate(kCFAllocatorDefault, queryString as CFString, nil, nil) else {
			throw MDQueryError.queryCreateError
		}

		MDQuerySetSearchScope(query, [kMDQueryScopeComputer] as CFArray, 0)

		guard MDQueryExecute(query, CFOptionFlags(kMDQuerySynchronous.rawValue)) else {
			throw MDQueryError.queryExecuteError
		}

		let resultCount = MDQueryGetResultCount(query)
		var xcodes: [Xcode] = []

		for index in 0 ..< resultCount {
			guard let itemPointer = MDQueryGetResultAtIndex(query, index) else {
				continue
			}
			let item = Unmanaged<MDItem>.fromOpaque(itemPointer).takeUnretainedValue()
			guard let path = MDItemCopyAttribute(item, kMDItemPath) as? String else {
				continue
			}

			let absolutePath = try AbsolutePath(validating: path)
			let version = try versionAtPath(absolutePath)

			xcodes.append(Xcode(path: absolutePath, version: version))
		}

		return xcodes
	}

	static func versionAtPath(_ path: AbsolutePath) throws -> Version {
		let plistPath = path.appending(components: "Contents", "Info.plist")
		let plist = try PropertyListSerialization.propertyList(from: Data(contentsOf: plistPath), format: nil)
		guard
			let info = plist as? [String: Any],
			let versionString = info["CFBundleShortVersionString"] as? String
		else {
			throw XcodeUtilsError.plistCFBundleShortStringNotFound
		}

		guard let version = Version(tolerant: versionString) else {
			throw XcodeUtilsError.unableToParseXcodeVersionString
		}

		return version
	}

	// static var selectedXcodeVersion: Xcode? {
	// 	let versions = try? installedXcodeVersions()
	// 	let selectedVersion = versions?.first { $0.path.contains("Xcode_") }
	// 	return selectedVersion
	// }
}

extension Data {
	init(contentsOf path: AbsolutePath) throws {
		let url = URL(filePath: path.pathString)
		self = try Data(contentsOf: url)
	}
}

import CoreServices
import Foundation
import Path
import Version

public enum MDQueryError: Error {
	case queryCreateError
	case queryExecuteError
}

public enum XcodeUtilsError: Error {
	case plistCFBundleShortStringNotFound
	case unableToParseXcodeVersionString
}

public struct Xcode: Codable {
	public let path: AbsolutePath
	public let version: Version

	public init(path: AbsolutePath, version: Version? = nil) throws {
		self.path = path

		if let version = version {
			self.version = version
		} else {
			self.version = try XcodeUtils.versionAtPath(path)
		}
	}
}

public enum XcodeUtils {
	public static func installedXcodeVersions() throws -> [Xcode] {
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

			xcodes.append(try Xcode(path: absolutePath, version: version))
		}

		return xcodes
	}

	public static func versionAtPath(_ path: AbsolutePath) throws -> Version {
		let plistPath: AbsolutePath
		if path.components.last == "Contents" {
			plistPath = path.appending(components: "Info.plist")
		} else if path.components.last == "Developer" {
			plistPath = path.parentDirectory.appending(components: "Info.plist")
		} else {
			plistPath = path.appending(components: "Contents", "Info.plist")
		}
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

	public static func selectedXcodeVersion() throws -> Xcode? {
		if let developerDir = ProcessInfo.processInfo.environment["DEVELOPER_DIR"] {
			return try Xcode(path: AbsolutePath(validating: developerDir))
		}

		let xcodeSelectLinkPath = "/var/db/xcode_select_link"
		if FileManager.default.fileExists(atPath: xcodeSelectLinkPath) {
			let xcodeSelectLink = try FileManager.default.destinationOfSymbolicLink(atPath: xcodeSelectLinkPath)
			return try Xcode(path: AbsolutePath(validating: xcodeSelectLink))
		}

		let xcodeDirLinkPath = "/usr/share/xcode-select/xcode_dir_link"
		if FileManager.default.fileExists(atPath: xcodeDirLinkPath) {
			let xcodeDirLink = try FileManager.default.destinationOfSymbolicLink(atPath: xcodeDirLinkPath)
			return try Xcode(path: AbsolutePath(validating: xcodeDirLink))
		}

		return nil
	}
}

extension Data {
	init(contentsOf path: AbsolutePath) throws {
		let url = URL(filePath: path.pathString)
		self = try Data(contentsOf: url)
	}
}

import Foundation

struct SystemVersion {
	let buildID: String
	let productBuildVersion: String
	let productCopyright: String
	let productName: String
	let productUserVisibleVersion: String
	let productVersion: String
	let iOSSupportVersion: String
}

extension SystemVersion: Decodable {
	enum CodingKeys: String, CodingKey {
		case buildID = "BuildID"
		case productBuildVersion = "ProductBuildVersion"
		case productCopyright = "ProductCopyright"
		case productName = "ProductName"
		case productUserVisibleVersion = "ProductUserVisibleVersion"
		case productVersion = "ProductVersion"
		case iOSSupportVersion = "iOSSupportVersion"
	}

	init() throws {
		let plistURL = URL(filePath: "/System/Library/CoreServices/SystemVersion.plist")
		let plistData = try Data(contentsOf: plistURL)
		self = try PropertyListDecoder().decode(SystemVersion.self, from: plistData)
	}
}

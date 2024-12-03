import Foundation
import MetaCodable

@Codable
public struct Secret {
	public let id: Int
	public let bundle: String

	@CodedAt("display_bundle")
	public let displayBundle: String?
	public let keypath: String?
	public let description: String?
	public let datatype: String?
	public let widget: String?
	public let title: String?
	public let values: String?

	@CodedAt("defaultvalue")
	public let defaultValue: String?
	@CodedAt("minversion")
	public let minVersion: String?
	@CodedAt("maxversion")
	public let maxVersion: String?
	@CodedAt("minosversion")
	public let minosVersion: String?
	@CodedAt("maxosversion")
	public let maxosVersion: String?

	public let units: String?
	public let group: String?
	public let placeholder: String?
	public let created: Date?
	public let updated: Date?
	public let hidden: Bool?
	@CodedAt("is_keypath")
	public let isKeyPath: Bool?
	public let verified: Bool?
	@CodedAt("top_secret")
	public let topSecret: Bool?
	@CodedAt("dangerous")
	public let dangerous: Bool?
	@CodedAt("current_host_only")
	public let currentHostOnly: Bool?
	@CodedAt("set_for_all_users")
	public let setForAllUsers: Bool?
}

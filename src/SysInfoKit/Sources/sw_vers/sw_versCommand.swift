import Foundation

public protocol RunnableCommand {
	var executable: URL { get }
	var arguments: [String] { get }
}

public struct sw_versCommand: RunnableCommand {
	public let executable: URL
	public let arguments: [String]

	public static let defaultExecutable = URL(fileURLWithPath: "/usr/bin/sw_vers")

	public init(
		executable: URL = defaultExecutable,
		arguments: [String] = []
	) {
		self.executable = executable
		self.arguments = arguments
	}

	public init(
		executable: URL = defaultExecutable,
		input: sw_versInput
	) {
		self.executable = executable
		self.arguments = input.flags.map { $0.rawValue }
	}
}

public struct sw_versInput {
	public let flags: [Flag]

	public enum Flag: String {
		case help = "--help"
		case productName = "--productName"
		case productVersion = "--productVersion"
		case productVersionExtra = "--productVersionExtra"
		case buildVersion = "--buildVersion"
	}

	public struct FlagSet: OptionSet, Sendable {
		public let rawValue: UInt

		public init(rawValue: UInt) {
			self.rawValue = rawValue
		}

		static let help = FlagSet(rawValue: 1 << 0)
		static let productName = FlagSet(rawValue: 1 << 1)
		static let productVersion = FlagSet(rawValue: 1 << 2)
		static let productVersionExtra = FlagSet(rawValue: 1 << 3)
		static let buildVersion = FlagSet(rawValue: 1 << 4)
	}
}

public struct sw_versOutput: Codable {
	public let productName: String
	public let productVersion: String
	public let productVersionExtra: String?
	public let buildVersion: String

	init(
		productName: String,
		productVersion: String,
		productVersionExtra: String?,
		buildVersion: String
	) {
		self.productName = productName
		self.productVersion = productVersion
		self.productVersionExtra = productVersionExtra
		self.buildVersion = buildVersion
	}

	init(from output: String) {
		let lines = output.split(separator: "\n")
		var productName: String?
		var productVersion: String?
		var productVersionExtra: String?
		var buildVersion: String?

		for line in lines {
			let parts = line.split(separator: ":").map { $0.trimmingCharacters(in: .whitespaces) }
			guard parts.count == 2 else { continue }

			switch parts[0] {
			case "ProductName":
				productName = parts[1]
			case "ProductVersion":
				productVersion = parts[1]
			case "ProductVersionExtra":
				productVersionExtra = parts[1]
			case "BuildVersion":
				buildVersion = parts[1]
			default:
				break
			}
		}

		self.productName = productName ?? ""
		self.productVersion = productVersion ?? ""
		self.productVersionExtra = productVersionExtra
		self.buildVersion = buildVersion ?? ""
	}
}

import Foundation

// swift-format-ignore: TypeNamesShouldBeCapitalized
enum sw_vers {
	static func run(
		arguments: [String] = ProcessInfo.processInfo.arguments
	) throws -> String {
		let usage = "Usage: sw_vers [--help|--productName|--productVersion|--productVersionExtra|--buildVersion]"

		let arguments = sw_versArgument.process(arguments)

		let systemVersion = try SystemVersion()

		guard arguments.isEmpty == false else {
			let output = """
				ProductName:		\(systemVersion.productName)
				ProductVersion:		\(systemVersion.productVersion)
				BuildVersion:		\(systemVersion.productBuildVersion)
				"""
			return output
		}

		switch arguments {
			case _ where arguments.contains(.productName):
				return systemVersion.productName
			case _ where arguments.contains(.productVersion):
				return systemVersion.productVersion
			case _ where arguments.contains(.productVersionExtra):
				// TODO: Figure out how to handle `productVersionExtra`
				return ""
			case _ where arguments.contains(.buildVersion):
				return systemVersion.productBuildVersion
			default:
				return usage
		}
	}

	// swift-format-ignore: TypeNamesShouldBeCapitalized
	enum sw_versArgument: String, CaseIterable {
		case help
		case productName
		case productVersion
		case productVersionExtra
		case buildVersion

		init?(rawValue: String) {
			for argument in sw_versArgument.allCases {
				let trimmedRawValue = rawValue.replacingOccurrences(of: "-", with: "")
				if trimmedRawValue.localizedLowercase == argument.rawValue.localizedLowercase {
					self = argument
					return
				}
			}
			return nil
		}

		static func process(_ arguments: [String]) -> [sw_versArgument] {
			arguments.compactMap { sw_versArgument(rawValue: $0) }
		}
	}
}

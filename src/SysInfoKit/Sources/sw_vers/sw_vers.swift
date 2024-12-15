import Command
import Foundation

protocol ShellCreated {
	var rawOutput: String { get }
}

public struct sw_vers: ShellCreated {
	public let productName: String
	public let productVersion: String
	public let productVersionExtra: String?
	public let buildVersion: String
	public let rawOutput: String

	public init(
		productName: String,
		productVersion: String,
		productVersionExtra: String?,
		buildVersion: String,
		rawOutput: String
	) {
		self.productName = productName
		self.productVersion = productVersion
		self.productVersionExtra = productVersionExtra
		self.buildVersion = buildVersion
		self.rawOutput = rawOutput
	}

	public init() async throws {
		let commandInput = sw_versInput(flags: [])
		let command = sw_versCommand(input: commandInput)
		let arguments = [command.executable.path] + command.arguments

		let rawOutput = try await CommandRunner().run(
			arguments: arguments
		).concatenatedString()

		let output = sw_versOutput(from: rawOutput)

		self.init(
			productName: output.productName,
			productVersion: output.productVersion,
			productVersionExtra: output.productVersionExtra,
			buildVersion: output.buildVersion,
			rawOutput: rawOutput
		)
	}
}

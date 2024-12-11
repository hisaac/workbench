import ArgumentParser
import Foundation

protocol RunnableCommand {
	var binary: URL { get }
	var arguments: [String] { get }
}

public struct sw_vers: ParsableCommand, RunnableCommand {
	public static var configuration = CommandConfiguration(
		commandName: "sw_vers",
		abstract: "Print macOS system version information"
	)

	@Flag(help: "Print the product name")
	public var productName: Bool = false

	@Flag(help: "Print the product version")
	public var productVersion: Bool = false

	@Flag(help: "Print the product version extra")
	public var productVersionExtra: Bool = false

	@Flag(help: "Print the build version")
	public var buildVersion: Bool = false

	public var binary: URL = sw_vers.defaultBinary

	public static let defaultBinary = URL(fileURLWithPath: "/usr/bin/sw_vers")

	public var arguments: [String] {
		var args = [String]()
		if productName { args.append("--productName") }
		if productVersion { args.append("--productVersion") }
		if productVersionExtra { args.append("--productVersionExtra") }
		if buildVersion { args.append("--buildVersion") }
		return args
	}

	public init() {
		self.init(binary: sw_vers.defaultBinary)
	}

	public init(
		binary: URL = sw_vers.defaultBinary,
		productName: Bool = false,
		productVersion: Bool = false,
		productVersionExtra: Bool = false,
		buildVersion: Bool = false
	) {
		self.binary = binary
		self.productName = productName
		self.productVersion = productVersion
		self.productVersionExtra = productVersionExtra
		self.buildVersion = buildVersion
	}
}

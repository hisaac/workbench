import Foundation

// swift-format-ignore: TypeNamesShouldBeCapitalized
enum sw_versC {
	static func run(
		arguments: [String] = ProcessInfo.processInfo.arguments
	) throws -> String {
		let process = Process()
		process.executableURL = URL(filePath: "/usr/bin/sw_vers")
		process.arguments = arguments

		let standardOutputPipe = Pipe()
		process.standardOutput = standardOutputPipe

		try process.run()
		process.waitUntilExit()

		guard let resultData = try standardOutputPipe.fileHandleForReading.readToEnd(),
			var resultString = String(data: resultData, encoding: .utf8)
		else {
			return ""
		}
		guard resultString.hasSuffix("\n") else {
			return resultString
		}
		resultString.removeLast()
		return resultString
	}
}

import Foundation

protocol Shellable {
	associatedtype Command
	associatedtype Response
}

protocol Command {
	associatedtype Response: Codable

	var executableURL: URL { get }
	func run() -> Response
}

import Foundation
import Testing

@testable import SystemDefaults

@Test
func decodeSecretsPlist() async throws {
	let secretsPlist = try #require(Bundle.module.url(forResource: "Secrets", withExtension: "plist"))
	print(secretsPlist)
}

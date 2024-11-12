import Testing

@testable import SysInfoKit

@Suite
struct SystemVersionTests {

	@Test
	func testPlistInit() throws {
		let systemVersion = try SystemVersion()
		print(systemVersion)
		#expect(systemVersion != nil)
	}
}

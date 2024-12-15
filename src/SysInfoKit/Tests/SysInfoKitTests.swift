import Testing

@testable import SysInfoKit

@Suite
struct SysInfoKitTests {

	@Test
	func testPlistInit() throws {
		let thing = "test"
		print(thing)
		#expect(thing != nil)
	}
}

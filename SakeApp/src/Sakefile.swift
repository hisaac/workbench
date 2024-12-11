import Foundation
import Sake
import SwiftShell

@main
@CommandGroup
struct Commands: SakeApp {
	public static var hello: Command {
		Command(
			run: { _ in
				try runAndPrint("swift", "build")
			}
		)
	}
}

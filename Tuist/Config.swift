import Foundation
import ProjectDescription

let config: Config = {

	// Being we're in a global scope, we can't throw an `error`, so we're left with either force-trying
	// or putting the `try` in a `do` block and calling `fatalError` in the `catch` block if it fails.
	// The latter does technically work, but any error message reports the error as being on the `fatalError` line,
	// not the actual line where the error occurred. So using a force-try is clearer in this case.

	let xcodeVersionFile = Path("//.config/.xcode-version")
	let xcodeVersionFileContents = try! String(contentsOfFile: xcodeVersionFile.pathString, encoding: .utf8)
	let xcodeVersionFileContentsTrimmed = xcodeVersionFileContents.trimmingCharacters(in: .whitespacesAndNewlines)
	let xcodeVersion = Version(stringLiteral: xcodeVersionFileContentsTrimmed)

	let swiftVersionFile = Path("//.config/.swift-version")
	let swiftVersionFileContents = try! String(contentsOfFile: swiftVersionFile.pathString, encoding: .utf8)
	let swiftVersionFileContentsTrimmed = swiftVersionFileContents.trimmingCharacters(in: .whitespacesAndNewlines)
	let swiftVersion = Version(stringLiteral: swiftVersionFileContentsTrimmed)

	return Config(
		compatibleXcodeVersions: .exact(xcodeVersion),
		swiftVersion: swiftVersion,
		generationOptions: .options(
			disablePackageVersionLocking: true,
			staticSideEffectsWarningTargets: .all
		)
	)
}()

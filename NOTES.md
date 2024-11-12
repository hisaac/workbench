# Notes

This document contains notes to myself for reference later.

## Example Commands

### Shell Commands

#### User Accounts

Can use the `dscl` binary, or the OpenDirectory framework.

Some examples of using `dscl`:

Get all user accounts on the machine

```shell
/usr/bin/dscl -plist localhost readall /Local/Default/Users UniqueID RecordName RealName NFSHomeDirectory HomeDirectory IsHidden
```

Get user accounts in the admin group

```shell
/usr/bin/dscl -plist localhost read /Local/Default/Groups/admin GroupMembership
```

Some examples of using OpenDirectory:

```swift
import OpenDirectory

let session = ODSession.default()
let node = try ODNode(session: session, name: "/Local/Default")
let query = try ODQuery(
	node: node,
	forRecordTypes: kODRecordTypeUsers,
	attribute: nil,
	matchType: 0,
	queryValues: nil,
	returnAttributes: nil,
	maximumResults: 0
)

let results = try query.resultsAllowingPartial(false)
for result in results {
	dump(result)
}
```

Library for styled TUI components: <https://github.com/dduan/Termbox>

Information about Mac computers located at `/System/Library/PrivateFrameworks/ServerInformation.framework/Versions/A/Resources/en.lproj/SIMachineAttributes.plist`

```swift
import OSLog

// Extension that makes it a breeze to create a logger that is
// configured with an appropriate subsystem and category ✨
// source: // Source: https://mastodon.social/@simonbs/111985986963709036
extension Logger {
	init<T>(forType type: T.Type) {
		let subsystem = Bundle.main.bundleIdentifier!
		let category = String(describing: type)
		self.init(subsystem: subsystem, category: category)
	}
}

// Example usage 👇
struct MyStruct {
	private let logger = Logger(forType: Self.self)

	func performOperation() {
		logger.info("Performing operation...")
		// ...
		logger.info("Did perform operation.")
	}
}
```

- https://github.com/QiuZhiFei/swift-commands
- https://macdevelopers.wordpress.com/2014/01/24/programmatically-retrieving-system-information-on-mac/
- https://opensource.apple.com/source/system_cmds/system_cmds-541/sysctl.tproj/sysctl.c?txt
- https://opensource.apple.com/source/system_cmds/
- https://opensource.apple.com/source/DarwinTools/
- https://theapplewiki.com/wiki/Filesystem:/System/Library/PrivateFrameworks
- https://robnapier.net/understanding-systemprofiler
- https://github.com/keith/dyld-shared-cache-extractor
- https://github.com/joshua-d-miller/macOSLAPS
- https://github.com/freegeek-pdx/mkuser

- [In the Hunt for the macOS AutoLogin Setup Process](https://www.offsec.com/blog/in-the-hunt-for-the-macos-autologin-setup-process/)

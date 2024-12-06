import Foundation
import SystemDefaults

protocol Default {
	var key: String { get }
	var domain: String { get }
	var value: PropertyListValue? { get set }
}

extension Default {
	var value: PropertyListValue? {
		get {
			SystemDefaults.standard.object(
				for: key,
				domain: domain,
				user: kCFPreferencesCurrentUser as String,
				host: kCFPreferencesCurrentHost as String
			)
		}
		set {
			SystemDefaults.standard.set(
				newValue,
				for: key,
				domain: domain,
				user: SystemDefaults.currentUser,
				host: SystemDefaults.currentHost
			)
		}
	}
}

struct AppleInterfaceStyle: Default {
	let key = "AppleInterfaceStyle"
	let domain = SystemDefaults.userGlobalDomain
}

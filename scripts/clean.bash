#!/bin/bash

function main() {
	declare -r project_root="$1"
	declare -r nuke="${2:-}"
	clean
	if [[ "${nuke}" == "nuke" || "${nuke}" == "true" ]]; then
		nuke
	fi
}

function clean() {
	killall -q Xcode || true

	"${HOME}/.local/bin/mise" exec -- tuist clean --path "${project_root}"

	find "${project_root}" -type d -name '.build' -exec rm -rf {} +
	find "${project_root}" -type d -name 'DerivedData' -exec rm -rf {} +
	find "${project_root}" -type f -name 'Package.resolved' -exec rm -rf {} +
	find "${project_root}" -type d -name '*.xcodeproj' -exec rm -rf {} +
	find "${project_root}" -type d -name '*.xcworkspace' -exec rm -rf {} +
	find "${project_root}" -type d -name '.venv' -exec rm -rf {} +
	find "${project_root}" -type d -name '__pycache__' -exec rm -rf {} +
	rm -rf "${project_root}/Derived"
}

function nuke() {
	rm -rf "${HOME}/Library/Developer/Xcode/DerivedData"
	rm -rf "${HOME}/Library/Caches/org.swift.swiftpm"
	rm -rf "${HOME}/Library/org.swift.swiftpm"
}

main "$@"

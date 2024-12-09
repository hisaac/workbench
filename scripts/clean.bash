#!/bin/bash

source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib/base.bash"
trap 'exit_handler "$?" "${0##*/}"' EXIT

function main() {
	declare -r nuke="${1:-}"
	clean
	if [[ "${nuke}" == "nuke" || "${nuke}" == "true" ]]; then
		nuke
	fi
}

function clean() {
	killall -q Xcode || true
	mise_exec tuist clean --path "${PROJECT_ROOT}"
	find "${PROJECT_ROOT}" -type d -name '.build' -exec rm -rf {} +
	find "${PROJECT_ROOT}" -type d -name 'DerivedData' -exec rm -rf {} +
	find "${PROJECT_ROOT}" -type f -name 'Package.resolved' -exec rm -rf {} +
	find "${PROJECT_ROOT}" -type d -name '*.xcodeproj' -exec rm -rf {} +
	find "${PROJECT_ROOT}" -type d -name '*.xcworkspace' -exec rm -rf {} +
	find "${PROJECT_ROOT}" -type d -name '.venv' -exec rm -rf {} +
	find "${PROJECT_ROOT}" -type d -name '__pycache__' -exec rm -rf {} +
	rm -rf "${PROJECT_ROOT}/Derived"
}

function nuke() {
	rm -rf "${HOME}/Library/Developer/Xcode/DerivedData"
	rm -rf "${HOME}/Library/Caches/org.swift.swiftpm"
	rm -rf "${HOME}/Library/org.swift.swiftpm"
}

main "$@"
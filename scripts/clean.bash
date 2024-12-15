#!/bin/bash

source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib/base.bash"
trap 'exit_handler "$?" "${0##*/}"' EXIT

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

	find "${project_root}" -type d -name '__pycache__' -exec rm -rf {} +
	find "${project_root}" -type d -name '.build' -exec rm -rf {} +
	find "${project_root}" -type d -name '.venv' -exec rm -rf {} +
	find "${project_root}" -type d -name '*.egg-info' -exec rm -rf {} +
	find "${project_root}" -type d -name '*.xcodeproj' -exec rm -rf {} +
	find "${project_root}" -type d -name '*.xcworkspace' -exec rm -rf {} +
	find "${project_root}" -type d -name 'DerivedData' -exec rm -rf {} +
	find "${project_root}" -type f -name 'Package.resolved' -exec rm -rf {} +

	rm -rf "${project_root}/Derived"

	sed -i '' '/LAST_UPDATE_CHECK/d' "${project_root}/.env"
}

function nuke() {
	rm -rf "${HOME}/Library/Developer/Xcode/DerivedData"
	rm -rf "${HOME}/Library/Caches/org.swift.swiftpm"
	rm -rf "${HOME}/Library/org.swift.swiftpm"
}

main "$@"

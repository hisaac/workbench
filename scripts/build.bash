#!/bin/bash

source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib/base.bash"
trap 'exit_handler "$?" "${0##*/}"' EXIT

function main() {
	xcrun_exec swift build --package-path "${PROJECT_ROOT}" "$@"
}

main "$@"

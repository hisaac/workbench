#!/bin/bash

source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib/base.bash"
trap 'exit_handler "$?" "${0##*/}"' EXIT

function main() {
	mise_exec tuist run --path "${PROJECT_ROOT}" "$@"
}

main "$@"

#!/bin/bash

source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib/base.bash"
trap 'exit_handler "$?" "${0##*/}"' EXIT

function main() {
	format_scripts
	format_swift
}

function format_scripts() {
	info "Formatting scripts"
	mise_exec shfmt --write "${SCRIPTS_DIR}"
}

function format_swift() {
	info "Formatting Swift Files"
	xcrun_exec swift-format format \
		--configuration "${CONFIG_DIR}/swift-format.json" \
		--in-place \
		--recursive \
		"${SOURCES_DIR}" \
		"${TUIST_DIR}" \
		"${PROJECT_ROOT}/Project.swift" \
		"${PROJECT_ROOT}/Tuist.swift"
}

main "$@"

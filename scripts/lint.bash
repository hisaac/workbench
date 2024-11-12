#!/bin/bash

source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib/base.bash"
trap 'exit_handler "$?" "${0##*/}"' EXIT

function main() {
	lint_scripts
	lint_swift
	lint_yaml
}

function lint_scripts() {
	info "Linting scripts"

	while IFS= read -r file; do
		files+=("$file")
	done < <(find "${SCRIPTS_DIR}" -type f -name "*.bash")

	if [ ${#files[@]} -gt 0 ]; then
		mise_exec shellcheck "${files[@]}"
	fi
}

function lint_swift() {
	info "Linting Swift"
	xcrun_exec swift-format lint \
		--configuration "${CONFIG_DIR}/swift-format.json" \
		--recursive "${SOURCES_DIR}" \
		--parallel

	xcrun_exec swift-format lint \
		--configuration "${CONFIG_DIR}/swift-format.json" \
		--recursive "${TUIST_DIR}" \
		--parallel

	xcrun_exec swift-format lint \
		--configuration "${CONFIG_DIR}/swift-format.json" \
		--recursive "${PROJECT_ROOT}/Project.swift" \
		--parallel
}

function lint_yaml() {
	info "Linting YAML"
	mise_exec yamllint \
		--config-file "${CONFIG_DIR}/.yamllint.yml" \
		"${PROJECT_ROOT}"
}

main "$@"

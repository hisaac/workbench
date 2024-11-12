#!/bin/bash

source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib/base.bash"
trap 'exit_handler "$?" "${0##*/}"' EXIT

function main() {
	if [[ -f "${MISE_BIN}" ]]; then
		update_mise
	else
		install_mise
	fi

	install_plugins

	select_xcode_version
}

function select_xcode_version() {
	mise_exec xcodes select "${XCODE_VERSION}"
}

function install_mise() {
	info "Installing mise"
	curl https://mise.run | sh
	eval "$("${MISE_BIN}" activate -C "$PROJECT_ROOT" bash --shims)"
}

function update_mise() {
	info "Updating mise"
	"${MISE_BIN}" self-update --yes || true # Ignore errors if mise is already up-to-date
}

function install_plugins() {
	info "Installing mise plugins"
	"${MISE_BIN}" install --yes
}

main "$@"

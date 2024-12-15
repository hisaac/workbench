#!/bin/bash

source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib/base.bash"
trap 'exit_handler "$?" "${0##*/}"' EXIT

function main() {
	if [[ -f "${MISE_BIN}" ]]; then
		maybe_update
	else
		install_mise
		do_updates
	fi

	select_xcode_version
}

function maybe_update() {
	if [[ -z "${LAST_UPDATE_CHECK:-}" ]]; then
		do_updates
		return
	fi

	declare -ri epoch_time="$(date +%s)"
	declare -ri seconds_since_update="$((epoch_time - LAST_UPDATE_CHECK))"
	declare -ri one_day_in_seconds=86400

	if [[ "${seconds_since_update}" -gt "${one_day_in_seconds}" ]]; then
		do_updates
	fi
}

function do_updates() {
	info "Running daily updates"
	update_mise
	install_mise_plugins
	install_python_dependencies
	update_timestamp
}

function update_timestamp() {
	declare -ri epoch_time="$(date +%s)"
	if grep -q "^LAST_UPDATE_CHECK=" "${ENV_FILE}"; then
		sed -i '' "s/^LAST_UPDATE_CHECK=.*/LAST_UPDATE_CHECK=${epoch_time}/" "${ENV_FILE}"
	else
		echo "LAST_UPDATE_CHECK=${epoch_time}" >>"${ENV_FILE}"
	fi
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

function install_mise_plugins() {
	info "Installing mise plugins"
	"${MISE_BIN}" install --yes
}

function install_python_dependencies() {
	info "Installing Python dependencies"
	mise_exec pip install -e .
}

function select_xcode_version() {
	mise_exec xcodes select "${XCODE_VERSION}"
}

main "$@"

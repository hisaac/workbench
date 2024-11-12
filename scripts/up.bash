#!/bin/bash

source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib/base.bash"
trap 'exit_handler "$?" "${0##*/}"' EXIT

function main() {
	if [[ -f "${MISE_BIN}" ]]; then
		maybe_update_mise
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

function maybe_update_mise() {
	if [[ -z "${MISE_UPDATE_CHECK:-}" ]]; then
		update_mise
		return
	fi

	declare -ri epoch_time="$(date +%s)"
	declare -ri seconds_since_mise_update="$((epoch_time - MISE_UPDATE_CHECK))"
	declare -ri one_day_in_seconds=86400

	if [[ "${seconds_since_mise_update}" -gt "${one_day_in_seconds}" ]]; then
		update_mise
	fi
}

function update_mise() {
	info "Updating mise"
	"${MISE_BIN}" self-update --yes || true # Ignore errors if mise is already up-to-date

	# Update the timestamp in the .env file
	declare -ri epoch_time="$(date +%s)"
	if grep -q "^MISE_UPDATE_CHECK=" "${ENV_FILE}"; then
		sed -i '' "s/^MISE_UPDATE_CHECK=.*/MISE_UPDATE_CHECK=${epoch_time}/" "${ENV_FILE}"
	else
		echo "MISE_UPDATE_CHECK=${epoch_time}" >> "${ENV_FILE}"
	fi
}

function install_plugins() {
	info "Installing mise plugins"
	"${MISE_BIN}" install --yes
}

main "$@"

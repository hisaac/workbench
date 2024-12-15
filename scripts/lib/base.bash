#!/bin/bash

# To use this in your script, add
#
# 	source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib/base.bash"
# 	trap 'exit_handler "$?" "${0##*/}"' EXIT
#
# at the top of your script

set -o errexit  # Exit on error
set -o nounset  # Exit on unset variable
set -o pipefail # Exit on pipe failure
IFS=$'\n\t'

source "$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")/logging.bash"

# "public" functions - run by consumers

function mise_exec() {
	"${MISE_BIN}" exec -- "$@"
}

function xcrun_exec() {
	/usr/bin/xcrun "$@"
}

function exit_handler() {
	declare -ri exit_code="$1"
	declare -r script_name="$2"
	if [[ "${exit_code}" -ne 0 ]]; then
		error "${script_name} exited with code ${exit_code}"
	elif [[ "${VERBOSE:-false}" == true ]]; then
		info "${script_name} exited with code ${exit_code}"
	fi
}

# "private" functions - run on script load

function _export_vars() {
	declare -r project_root="$(dirname "$(dirname "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")")")"
	export PROJECT_ROOT="${PROJECT_ROOT:-$project_root}"

	export ENV_FILE="${ENV_FILE:-$PROJECT_ROOT/.env}"
	if [[ ! -f "${ENV_FILE}" ]]; then
		touch "${ENV_FILE}"
	fi

	# shellcheck source=../.env
	source "${ENV_FILE}"

	export CONFIG_DIR="${CONFIG_DIR:-$PROJECT_ROOT/.config}"
	export SCRIPTS_DIR="${SCRIPTS_DIR:-$PROJECT_ROOT/scripts}"
	export SOURCES_DIR="${SOURCES_DIR:-$PROJECT_ROOT/src}"

	export MISE_BIN="${HOME}/.local/bin/mise"

	declare -r xcode_version_file="${CONFIG_DIR}/.xcode-version"
	declare -r xcode_version_file_contents="$(<"${xcode_version_file}" tr -d '[:space:]')"
	export XCODE_VERSION="${XCODE_VERSION:-$xcode_version_file_contents}"
}
_export_vars

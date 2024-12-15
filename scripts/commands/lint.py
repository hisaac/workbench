import argparse
import subprocess

from commands import (
	SCRIPTS_DIR,
	MISE_BIN,
	PROJECT_ROOT,
	CONFIG_DIR,
	SOURCES_DIR,
	XCRUN_BIN,
)


def setup_parser(subparser) -> argparse.ArgumentParser:
	return subparser.add_parser("lint", help="Lint the project")


def handle(args) -> None:
	lint_bash()
	lint_swift()
	lint_yaml()
	lint_python()


def lint_bash() -> None:
	print("Linting bash")
	bash_files = list(SCRIPTS_DIR.glob("*.bash"))
	subprocess.run([MISE_BIN, "exec", "--", "shellcheck", *bash_files], check=True)


def lint_swift() -> None:
	print("Linting swift")
	subprocess.run(
		[
			XCRUN_BIN,
			"swift-format",
			"lint",
			"--configuration",
			CONFIG_DIR / "swift-format.json",
			"--recursive",
			SOURCES_DIR,
			PROJECT_ROOT / "Package.swift",
		],
		check=True,
	)


def lint_yaml() -> None:
	print("Linting yaml")
	subprocess.run(
		[
			MISE_BIN,
			"exec",
			"--",
			"yamllint",
			"--config-file",
			CONFIG_DIR / ".yamllint.yml",
			PROJECT_ROOT,
		],
		check=True,
	)


def lint_python() -> None:
	print("Linting python")
	subprocess.run(
		[MISE_BIN, "exec", "--", "ruff", "format", "--check", SCRIPTS_DIR], check=True
	)

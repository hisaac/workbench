import argparse
import subprocess

from commands import (
    CONFIG_DIR,
    MISE_BIN,
    PROJECT_ROOT,
    SCRIPTS_DIR,
    SOURCES_DIR,
    TUIST_DIR,
    XCRUN_BIN,
)


def setup_parser(subparser) -> argparse.ArgumentParser:
    return subparser.add_parser("format", help="Format the project")


def handle(args) -> None:
    format_bash()
    format_swift()
    format_python()


def format_bash() -> None:
    subprocess.run(
        [MISE_BIN, "exec", "--", "shfmt", "--write", SCRIPTS_DIR], check=True
    )


def format_swift() -> None:
    subprocess.run(
        [
            XCRUN_BIN,
            "swift-format",
            "format",
            "--configuration",
            CONFIG_DIR / "swift-format.json",
            "--in-place",
            "--recursive",
            SOURCES_DIR,
            TUIST_DIR,
            PROJECT_ROOT / "Project.swift",
            PROJECT_ROOT / "Tuist.swift",
        ],
        check=True,
    )


def format_python() -> None:
    subprocess.run([MISE_BIN, "exec", "--", "black", SCRIPTS_DIR], check=True)

import argparse
import subprocess

from commands import (
	MISE_BIN,
	PROJECT_ROOT,
)


def setup_parser(subparser) -> argparse.ArgumentParser:
	return subparser.add_parser("build", help="Build the project using Tuist")


def handle(args) -> None:
	subprocess.run(
		[MISE_BIN, "exec", "--", "tuist", "build", "--path", PROJECT_ROOT], check=True
	)

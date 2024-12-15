import argparse
import subprocess

from commands import (
	PROJECT_ROOT,
	XCRUN_BIN,
)


def setup_parser(subparser) -> argparse.ArgumentParser:
	parser = subparser.add_parser("run", help="Run the project")
	parser.add_argument(
		"args", nargs="*", help="Additional arguments to pass to swift run"
	)
	return parser


def handle(args) -> None:
	subprocess.run(
		[
			XCRUN_BIN,
			"swift",
			"run",
			"--package-path",
			PROJECT_ROOT,
			*args.args,
		],
		check=True,
	)

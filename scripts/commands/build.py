import argparse
import subprocess

from commands import (
	PROJECT_ROOT,
	XCRUN_BIN,
)


def setup_parser(subparser) -> argparse.ArgumentParser:
	parser = subparser.add_parser("build", help="Build the project")
	parser.add_argument(
		"args", nargs="*", help="Additional arguments to pass to swift build"
	)
	return parser


def handle(args) -> None:
	subprocess.run(
		[
			XCRUN_BIN,
			"swift",
			"build",
			"--package-path",
			PROJECT_ROOT,
			*args.args,
		],
		check=True,
	)

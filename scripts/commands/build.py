import argparse
import subprocess

from commands import (
	MISE_BIN,
	PROJECT_ROOT,
)


def setup_parser(subparser) -> argparse.ArgumentParser:
	parser = subparser.add_parser("build", help="Build the project using Tuist")
	parser.add_argument(
		"args", nargs="*", help="Additional arguments to pass to tuist build"
	)
	return parser


def handle(args) -> None:
	subprocess.run(
		[
			MISE_BIN,
			"exec",
			"--",
			"tuist",
			"build",
			"--path",
			PROJECT_ROOT,
			*args.args,
		],
		check=True,
	)

import argparse
import subprocess

from commands import (
	MISE_BIN,
	PROJECT_ROOT,
)


def setup_parser(subparser) -> argparse.ArgumentParser:
	parser = subparser.add_parser("run", help="Run the project using Tuist")
	parser.add_argument(
		"args", nargs="*", help="Additional arguments to pass to tuist run"
	)
	return parser


def handle(args) -> None:
	subprocess.run(
		[
			MISE_BIN,
			"exec",
			"--",
			"tuist",
			"run",
			"--path",
			PROJECT_ROOT,
			*args.args,
		],
		check=True,
	)

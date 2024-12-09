import argparse
import subprocess

from commands import (
	MISE_BIN,
	PROJECT_ROOT,
)


def setup_parser(subparser) -> argparse.ArgumentParser:
	parser = subparser.add_parser("test", help="Test the project using Tuist")
	parser.add_argument(
		"args", nargs="*", help="Additional arguments to pass to tuist test"
	)
	return parser


def handle(args) -> None:
	subprocess.run(
		[
			MISE_BIN,
			"exec",
			"--",
			"tuist",
			"test",
			"--path",
			PROJECT_ROOT,
			*args.args,
		],
		check=True,
	)

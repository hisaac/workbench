import argparse


from commands import build
from commands import format
from commands import lint


def main():
	parser = argparse.ArgumentParser()
	subparsers = parser.add_subparsers(dest="command")

	build.setup_parser(subparsers)
	format.setup_parser(subparsers)
	lint.setup_parser(subparsers)

	args = parser.parse_args()

	if args.command == "build":
		build.handle(args)
	elif args.command == "format":
		format.handle(args)
	elif args.command == "lint":
		lint.handle(args)


if __name__ == "__main__":
	main()

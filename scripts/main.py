import argparse

from commands import clean

def main():
	parser = argparse.ArgumentParser()
	subparsers = parser.add_subparsers(dest='command')

	clean.setup_parser(subparsers)

	args = parser.parse_args()
	if args.command == 'clean':
		clean.handle(args)

if __name__ == '__main__':
	main()

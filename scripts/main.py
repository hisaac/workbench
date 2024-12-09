import argparse


from commands import build


def main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command")

    build.setup_parser(subparsers)

    args = parser.parse_args()

    if args.command == "build":
        build.handle(args)


if __name__ == "__main__":
    main()

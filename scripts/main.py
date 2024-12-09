import argparse


def main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command")

    args = parser.parse_args()


if __name__ == "__main__":
    main()

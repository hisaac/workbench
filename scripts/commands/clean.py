import argparse
import shutil
import subprocess

from pathlib import Path

from commands import PROJECT_ROOT, MISE_BIN, SCRIPTS_DIR


def setup_parser(subparsers) -> argparse.ArgumentParser:
    """Set up the clean subparser"""
    parser = subparsers.add_parser("clean", help="Clean generated files")
    parser.add_argument(
        "--nuke",
        action="store_true",
        help="Also clean system-wide Xcode and Swift PM caches",
    )
    return parser


def handle(args):
    clean(args)
    if args.nuke:
        nuke(args)


def clean(args):
    print("Cleaning generated files...")

    # Kill Xcode if running
    subprocess.run(["killall", "-q", "Xcode"], check=False)

    # Run tuist clean
    subprocess.run(
        [MISE_BIN, "exec", "--", "tuist", "clean", "--path", PROJECT_ROOT], check=False
    )

    patterns = [
        "__pycache__",
        ".build",
        "*.xcodeproj",
        "*.xcworkspace",
        "Derived",
        "DerivedData",
        "Package.resolved",
    ]

    for pattern in patterns:
        for path in PROJECT_ROOT.rglob(pattern):
            if path.is_dir():
                shutil.rmtree(path)
            else:
                path.unlink()

    print("Done")


def nuke(args):
    paths = [
        Path.home() / "Library/Developer/Xcode/DerivedData",
        Path.home() / "Library/Caches/org.swift.swiftpm",
        Path.home() / "Library/org.swift.swiftpm",
        SCRIPTS_DIR / ".venv",
    ]

    for path in paths:
        if path.is_dir():
            shutil.rmtree(path, ignore_errors=True)

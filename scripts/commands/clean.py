import argparse
import shutil
import subprocess

from pathlib import Path

from commands import PROJECT_ROOT, MISE_BIN


def setup_parser(subparsers) -> argparse.ArgumentParser:
    """Set up the clean subparser"""
    return subparsers.add_parser("clean", help="Clean generated files")


def handle(args):
    """Handle the clean command"""
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
        ".venv/",
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
    shutil.rmtree(Path.home() / "Library/Developer/Xcode/DerivedData")
    shutil.rmtree(Path.home() / "Library/Caches/org.swift.swiftpm")
    shutil.rmtree(Path.home() / "Library/org.swift.swiftpm")

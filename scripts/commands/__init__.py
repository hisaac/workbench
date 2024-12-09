from pathlib import Path

PROJECT_ROOT = Path(__file__).parent.parent.parent.resolve()
CONFIG_DIR = PROJECT_ROOT / ".config"
SCRIPTS_DIR = PROJECT_ROOT / "scripts"
SOURCES_DIR = PROJECT_ROOT / "src"
TUIST_DIR = PROJECT_ROOT / "tuist"

MISE_BIN = Path.home() / ".local/bin/mise"
XCRUN_BIN = "/usr/bin/xcrun"


def _get_xcode_version() -> str:
    """Get the Xcode version from the .xcode_version file

    Returns:
            str: The Xcode version

    Raises:
            FileNotFoundError: If the .xcode-version file is not found
    """

    xcode_version_file = CONFIG_DIR / ".xcode-version"

    if not xcode_version_file.exists():
        raise FileNotFoundError(f"Xcode version file not found at {xcode_version_file}")

    return xcode_version_file.read_text().strip()


XCODE_VERSION = _get_xcode_version()

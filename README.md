# workbench

This repository is a place for me to experiment with new tools and little projects. Consider anything here a work in progress, and if I consider it ready for use, I'll move it to a more permanent home.

# SysInfoKit

Library for introspecting information about the system currently running your code.

# `xcb`

`xcb` is a Swift CLI for interacting with the `xcodebuild` and `swift` CLI tools. It aims to provide nicer defaults, new features, and improved ergonomics.

> [!WARNING]
> This project is in the very early stages of development, and is not yet ready for real world usage.

## Goals

### Nicer Defaults

### New Features

- Ensure usage of the desired Xcode / Swift version if specified.

### Improved Ergonomics

- Define build settings in a config file.
- Easier selection of schemes and devices.
- Improved output formatting using [`xcbeautify`](https://github.com/cpisciotta/xcbeautify/).
- Common errors will automatically detected and displayed in a user-friendly manner.

## TODO

- [x] Use dependabot to keep the dependencies up to date.
- [ ] Use `xcbeautify` to format the output of the `xcodebuild` command.
- [ ] Implement build settings from a config file.
- [ ] Implement scheme selection.
- [ ] Implement device selection.
- [ ] Implement build destination selection.
- [ ] Implement build configuration selection.
- [ ] Use mise cache to speed up the build in CI.

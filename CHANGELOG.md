# Changelog

All notable changes to this project are documented here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project uses [semantic versioning](https://semver.org/). Syncloom is a public preview until 1.0.

## [0.1.0] - 2026-11-02

First public preview.

### Added
- Menu-bar app with Finder integration through a File Provider extension: files appear in the Finder sidebar and download on demand.
- Sign-in with a second factor, including hardware security keys through the browser. Live updates from the server.
- The app keeps running in the menu bar after its window is closed and can open at login ("Open Syncloom at login", on after the first sign-in).

### Fixed
- The File Provider extension no longer reports a file as deleted when a lookup fails for a network or server reason. Only "not found", 403, 404 and 410 count.
- Signing out or a refused token keeps edits that are not yet uploaded.

### Known limits
- Without the app running, Finder learns of server changes only when you open a folder.
- No signed or notarised build is published yet; build it from source with Xcode and XcodeGen.

# syncloom-macos

The macOS app (SwiftUI) with a menu-bar item and a Finder integration through a File Provider extension.

Part of [Syncloom](https://github.com/Syncloom), a self-hosted, end-to-end encrypted file sync and key/value store. Status: **public preview (0.1)**.

```bash
(cd ../syncloom-core && ./build-apple.sh)
brew install xcodegen && xcodegen && open Syncloom.xcodeproj
```
Needs `../syncloom-apple`. Signing and the File Provider entitlement need your own Apple developer team.

## Working with the other repositories

The Syncloom repositories reference each other by relative path. Clone the ones you need **side by side in one folder**, for example `syncloom-core`, `syncloom-server` and `syncloom-web` next to each other.

## License

Apache License 2.0, see [LICENSE](LICENSE).

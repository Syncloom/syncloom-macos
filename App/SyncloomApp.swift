import SwiftUI
import SyncloomKit

@main
struct SyncloomApp: App {
    init() {
        // the app and its File Provider extension share the signed-in session through this Keychain group
        Credentials.accessGroup = Bundle.main.object(forInfoDictionaryKey: "SyncloomKeychainGroup") as? String
    }

    var body: some Scene {
        WindowGroup("Syncloom") {
            RootView(device: Host.current().localizedName ?? "Mac")
                .frame(minWidth: 860, minHeight: 560)
        }
        .defaultSize(width: 1040, height: 680)
        .commands { CommandGroup(replacing: .newItem) {} }

        MenuBarExtra {
            MenuBarContent()
        } label: {
            Image("MenuGlyph")
        }
        .menuBarExtraStyle(.menu)
    }
}

struct MenuBarContent: View {
    @Environment(\.openWindow) private var openWindow
    var body: some View {
        Button("Open Syncloom") {
            NSApp.activate(ignoringOtherApps: true)
            if NSApp.windows.first(where: { $0.canBecomeMain }) == nil { openWindow(id: "Syncloom") }
            NSApp.windows.first(where: { $0.canBecomeMain })?.makeKeyAndOrderFront(nil)
        }
        Button("Show in Finder") { FileProviderRegistration.signalChanged(); NSWorkspace.shared.open(URL(string: "file:///")!) }
        Divider()
        Button("Quit Syncloom") { NSApplication.shared.terminate(nil) }.keyboardShortcut("q")
    }
}

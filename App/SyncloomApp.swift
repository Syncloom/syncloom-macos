import SwiftUI
import SyncloomKit

/// Owns the signed-in state for the whole life of the app, not of a window: closing the window must not stop
/// the live connection that keeps Finder current.
@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    let model = AppModel()

    func applicationDidFinishLaunching(_ n: Notification) {
        Task { await model.restore() }
        // started by macOS at login: stay in the menu bar without opening a window
        if LaunchAtLogin.launchedAtLogin { DispatchQueue.main.async { NSApp.windows.filter(\.canBecomeMain).forEach { $0.close() } } }
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ app: NSApplication) -> Bool { false }
}

@main
struct SyncloomApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var delegate

    init() {
        // the app and its File Provider extension share the signed-in session through this Keychain group
        Credentials.accessGroup = Bundle.main.object(forInfoDictionaryKey: "SyncloomKeychainGroup") as? String
    }

    var body: some Scene {
        WindowGroup("Syncloom", id: "Syncloom") {
            RootView(device: Host.current().localizedName ?? "Mac", model: delegate.model)
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

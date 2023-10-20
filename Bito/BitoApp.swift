import SwiftUI
import Ditto
import AppKit
import Sparkle

@main
struct BitoApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    
    public var container = DIContainer(isMock: false)
    public var statusItem: NSStatusItem?
    private var popOver = NSPopover()
    private var isAppOpen = false
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        let colorScheme = container.interactor.perference.getColorScheme()
        
        popOver.setValue(true, forKeyPath: "shouldHideAnchor")
        popOver.contentSize = .menubarSize
        popOver.behavior = .transient
        popOver.animates = true
        popOver.contentViewController = NSViewController()
        popOver.contentViewController = NSHostingController(
            rootView: ContentView(colorScheme: colorScheme)
                .textEditerCommand()
                .environment(\.injected, container)
                .environment(\.popOver, popOver)
                .hotkey(key: .kVK_ANSI_S, keyBase: [KeyBase.command, .option], action: {
                    self.togglePopover()
                })
        )
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        var config = NSImage.SymbolConfiguration(textStyle: .body, scale: .large)
        #if DEBUG
        var img = NSImage(systemSymbolName: "cloud.moon.fill", accessibilityDescription: nil)
        #else
        var img = NSImage(systemSymbolName: "cloud.moon.fill", accessibilityDescription: nil)
        config = config.applying(.init(paletteColors: [
            .init(red: 0, green: 0.5, blue: 1, alpha: 1),
            .init(red: 0.9, green: 0.7, blue: 0, alpha: 1),
        ]))
        #endif
        img = img?.withSymbolConfiguration(config)
        
        if let statusButton = statusItem?.button {
            statusButton.image = img
            statusButton.action = #selector(togglePopover)
        }
    }
    
    @objc public func togglePopover() {
        if let button = statusItem?.button {
            self.popOver.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.maxY)
            
            System.async {
                if Date.now > self.container.interactor.perference.getCheckUpdateAt().addDay(1){
                    self.container.interactor.perference.setCheckUpdateAt(.now)
                    self.container.interactor.updater.checkForUpdates()
                }
            } main: {}

            
            System.async {
                self.container.interactor.system.pushLoading(true)
                defer { self.container.interactor.system.pushLoading(false) }
                if self.container.interactor.web.isTokenExpired().0 { return }
                _ = self.container.interactor.web.fetchListWfh()
            } main: {}
        }
        
    }
    
}

extension NSPopover: EnvironmentKey {
    public static var defaultValue: NSPopover { NSPopover() }
}

extension EnvironmentValues {
    public var popOver: NSPopover {
        get { self[NSPopover.self] }
        set { self[NSPopover.self] = newValue }
    }
}


fileprivate struct KeyboardEventModifier: ViewModifier {
    enum Key: String {
        case a, c, v, x
    }
    
    let key: Key
    let modifiers: EventModifiers
    
    func body(content: Content) -> some View {
        content.keyboardShortcut(KeyEquivalent(Character(key.rawValue)), modifiers: modifiers)
    }
}

extension View {
    fileprivate func keyboardShortcut(_ key: KeyboardEventModifier.Key, modifiers: EventModifiers = .command) -> some View {
        modifier(KeyboardEventModifier(key: key, modifiers: modifiers))
    }
}

extension View {
    func textEditerCommand() -> some View {
        self
            .hotkey(key: .kVK_ANSI_A, keyBase: [KeyBase.command]) {
                NSApp.sendAction(#selector(NSText.selectAll(_:)), to: nil, from: nil)
            }
            .hotkey(key: .kVK_ANSI_C, keyBase: [KeyBase.command]) {
                NSApp.sendAction(#selector(NSText.copy(_:)), to: nil, from: nil)
            }
            .hotkey(key: .kVK_ANSI_X, keyBase: [KeyBase.command]) {
                NSApp.sendAction(#selector(NSText.cut(_:)), to: nil, from: nil)
            }
            .hotkey(key: .kVK_ANSI_V, keyBase: [KeyBase.command]) {
                NSApp.sendAction(#selector(NSText.paste(_:)), to: nil, from: nil)
            }
            .hotkey(key: .kVK_ANSI_Z, keyBase: [KeyBase.command]) {
                NSApp.sendAction(Selector(("undo:")), to: nil, from: nil)
            }
            .hotkey(key: .kVK_ANSI_Z, keyBase: [KeyBase.shift, KeyBase.command]) {
                NSApp.sendAction(Selector(("redo:")), to:nil, from:self)
            }
    }
}

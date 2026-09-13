import SwiftUI
import AppKit

struct WindowAccessor: NSViewRepresentable {

    func makeNSView(context: Context) -> NSView {
        let view = NSView()

        DispatchQueue.main.async {
            configure(view.window)
        }

        return view
    }

    func updateNSView(
        _ nsView: NSView,
        context: Context
    ) {
        DispatchQueue.main.async {
            configure(nsView.window)
        }
    }

    private func configure(_ window: NSWindow?) {
        guard let window else { return }

        // Allow dragging the receipt
        window.isMovableByWindowBackground = true

        // Window appearance
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
        window.styleMask.insert(.fullSizeContentView)

        // Receipt paper background
        window.backgroundColor = NSColor(
            red: 0.97,
            green: 0.97,
            blue: 0.95,
            alpha: 1.0
        )

        window.isOpaque = true
        window.hasShadow = true

        // Keep normal Mac window buttons
        window.standardWindowButton(.closeButton)?.isHidden = false
        window.standardWindowButton(.miniaturizeButton)?.isHidden = false
        window.standardWindowButton(.zoomButton)?.isHidden = false
    }
}
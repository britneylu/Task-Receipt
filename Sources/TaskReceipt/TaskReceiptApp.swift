import SwiftUI

@main
struct TaskReceiptApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate

    @StateObject private var store = TodoStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
        .windowStyle(.hiddenTitleBar)
        // .windowResizability(.contentSize)
    }
}
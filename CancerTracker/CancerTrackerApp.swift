import SwiftUI

@main
struct CancerTrackerApp: App {
    @StateObject private var store = EventStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}

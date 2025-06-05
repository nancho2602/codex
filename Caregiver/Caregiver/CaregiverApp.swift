import SwiftUI

@main
struct CaregiverApp: App {
    @StateObject private var store = EventStore()
    @StateObject private var categoryStore = CategoryStore()

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(store)
                .environmentObject(categoryStore)
        }
    }
}

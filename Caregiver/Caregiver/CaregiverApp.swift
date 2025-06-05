import SwiftUI

@main
struct CaregiverApp: App {
    @StateObject private var store = EventStore()
    @StateObject private var categoryStore = CategoryStore()
    @StateObject private var patientStore = PatientStore()

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(store)
                .environmentObject(categoryStore)
                .environmentObject(patientStore)
        }
    }
}

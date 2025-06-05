import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            NavigationLink("Patient Info") {
                PatientInfoView()
            }
            NavigationLink("Categories") {
                CategorySettingsView()
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
                .environmentObject(EventStore())
                .environmentObject(CategoryStore())
                .environmentObject(PatientStore())
        }
    }
}

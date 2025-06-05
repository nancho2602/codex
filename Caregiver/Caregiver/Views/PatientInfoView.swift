import SwiftUI

struct PatientInfoView: View {
    @EnvironmentObject var patientStore: PatientStore
    @State private var name: String
    @State private var dob: Date
    @Environment(\.presentationMode) var presentationMode

    init() {
        let store = PatientStore()
        _name = State(initialValue: store.fullName)
        _dob = State(initialValue: store.dateOfBirth)
    }

    var body: some View {
        Form {
            TextField("Full Name", text: $name)
            DatePicker("Date of Birth", selection: $dob, displayedComponents: .date)
            Button("Save") {
                patientStore.fullName = name
                patientStore.dateOfBirth = dob
                presentationMode.wrappedValue.dismiss()
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Patient Info")
    }
}

struct PatientInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PatientInfoView()
                .environmentObject(PatientStore())
        }
    }
}

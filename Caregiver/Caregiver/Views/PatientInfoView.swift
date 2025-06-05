import SwiftUI

struct PatientInfoView: View {
    @EnvironmentObject var patientStore: PatientStore
    @State private var name: String = ""
    @State private var dob: Date = Date()
    @Environment(\.presentationMode) var presentationMode


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
        .onAppear {
            name = patientStore.fullName
            dob = patientStore.dateOfBirth
        }

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

import Foundation

class PatientStore: ObservableObject {
    @Published var fullName: String {
        didSet { persist() }
    }
    @Published var dateOfBirth: Date {
        didSet { persist() }
    }

    private let nameKey = "PatientFullName"
    private let dobKey = "PatientDOB"

    init() {
        fullName = UserDefaults.standard.string(forKey: nameKey) ?? ""
        if let saved = UserDefaults.standard.object(forKey: dobKey) as? Date {
            dateOfBirth = saved
        } else {
            dateOfBirth = Date()
        }
    }

    private func persist() {
        UserDefaults.standard.set(fullName, forKey: nameKey)
        UserDefaults.standard.set(dateOfBirth, forKey: dobKey)
    }
}

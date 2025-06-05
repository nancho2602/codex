import Foundation

enum EventCategory: String, CaseIterable, Identifiable, Codable {
    case food, drink, medication, sleep, symptom

    var id: String { rawValue }

    var events: [String] {
        switch self {
        case .food:
            return ["Breakfast", "Lunch", "Dinner", "Snack"]
        case .drink:
            return ["Water", "Juice", "Tea", "Coffee"]
        case .medication:
            return ["Pill", "Injection", "Infusion"]
        case .sleep:
            return ["Nap", "Night Sleep"]
        case .symptom:
            return ["Nausea", "Vomiting", "Stomach Ache"]
        }
    }
}

struct Event: Identifiable, Codable {
    var id = UUID()
    var category: EventCategory
    var name: String
    var note: String
    var date: Date
}

import Foundation
import SwiftUI

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

    var color: Color {
        switch self {
        case .food:
            return .green
        case .drink:
            return .blue
        case .medication:
            return .orange
        case .sleep:
            return .purple
        case .symptom:
            return .red
        }
    }

    var icon: String {
        switch self {
        case .food:
            return "fork.knife"
        case .drink:
            return "cup.and.saucer.fill"
        case .medication:
            return "pills.fill"
        case .sleep:
            return "bed.double.fill"
        case .symptom:
            return "exclamationmark.triangle.fill"
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

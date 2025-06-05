import Foundation
import SwiftUI

class CategoryStore: ObservableObject {
    @Published var eventsByCategory: [EventCategory: [String]]

    private let storageKey = "CategoryStoreData"

    init() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let raw = try? JSONDecoder().decode([String: [String]].self, from: data) {
            var dict: [EventCategory: [String]] = [:]
            for (key, value) in raw {
                if let cat = EventCategory(rawValue: key) {
                    dict[cat] = value
                }
            }
            eventsByCategory = dict
        } else {
            var dict: [EventCategory: [String]] = [:]
            for cat in EventCategory.allCases {
                dict[cat] = cat.defaultEvents
            }
            eventsByCategory = dict
        }
    }

    private func persist() {
        let raw = eventsByCategory.reduce(into: [String: [String]]()) { res, pair in
            res[pair.key.rawValue] = pair.value
        }
        if let data = try? JSONEncoder().encode(raw) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    func events(for category: EventCategory) -> [String] {
        eventsByCategory[category] ?? []
    }

    func add(event: String, to category: EventCategory) {
        var list = eventsByCategory[category] ?? []
        list.append(event)
        eventsByCategory[category] = list
        persist()
    }

    func remove(atOffsets offsets: IndexSet, from category: EventCategory) {
        var list = eventsByCategory[category] ?? []
        list.remove(atOffsets: offsets)
        eventsByCategory[category] = list
        persist()
    }
}


import Foundation

class EventStore: ObservableObject {
    @Published var events: [Event] = []

    func add(_ event: Event) {
        events.append(event)
    }

    func update(_ event: Event) {
        guard let index = events.firstIndex(where: { $0.id == event.id }) else { return }
        events[index] = event
    }

    func remove(_ event: Event) {
        events.removeAll { $0.id == event.id }
    }
}

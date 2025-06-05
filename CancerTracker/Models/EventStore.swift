import Foundation

class EventStore: ObservableObject {
    @Published var events: [Event] = []

    func add(_ event: Event) {
        events.append(event)
    }
}

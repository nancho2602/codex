import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: EventStore
    @EnvironmentObject var categoryStore: CategoryStore

    private var groupedEvents: [(date: Date, events: [Event])] {
        let grouped = Dictionary(grouping: store.events) { event in
            Calendar.current.startOfDay(for: event.date)
        }

        return grouped
            .map { (date: $0.key, events: $0.value.sorted { $0.date < $1.date }) }
            .sorted { $0.date > $1.date }
    }

    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }

    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(groupedEvents, id: \.date) { day, events in
                    Section(header: Text(day, formatter: dayFormatter)) {
                        ForEach(events) { event in
                            NavigationLink(destination: AddEventView(event: event)) {
                                HStack(alignment: .top) {
                                    Image(systemName: event.category.icon)
                                        .foregroundColor(event.category.color)
                                    VStack(alignment: .leading) {
                                        Text("\(event.category.rawValue.capitalized): \(event.name)")
                                            .font(.headline)
                                        Text(event.note)
                                        Text(timeFormatter.string(from: event.date))
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Daily Events")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink("Settings") {
                        CategorySettingsView()
                    }
                    NavigationLink("Add") {
                        AddEventView()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(EventStore())
            .environmentObject(CategoryStore())
    }
}
